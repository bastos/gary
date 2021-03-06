# -*- coding: utf-8 -*-

$:.unshift File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'markaby'
require 'fileutils'
require 'ftools'
require 'albino'

# Gary Presentation Builder
# JS and part of the CSS from http://slideshow.rubyforge.org/
module Gary 
  
  #Main method to parse the ARGV.
  def self.main(args)
    if not args[0]
      self.usage 
    elsif args[0] == '--assets'
      self.create_assets
    else args[0] == '--render' or args[0] == '-r'
      self.generate(args[1])
    end
  end

  # Generate the presentation from a presentation file source.
  def self.generate(presentation_source)
      raise "File #{presentation_source} don't exists!" unless File.exists?(presentation_source)
      f = File.expand_path "#{presentation_source}"
      puts "Creating presentation: #{f}"
      p = Gary::Builder.new
      presentation_file = f.gsub(/\.rb$/, '')
      out = File.new( "#{presentation_file}.html", "w+" )
      out << p.instance_eval(File.new(f).read, f)    
      out.flush
      out.close    
  end
  
  # Create the assets directory with the standards files.
  # To use your custom theme just modify the assets/style.css generated by this method.
  # To restore just remove the style file and run --assets again.
  def self.create_assets
    Dir.mkdir( 'assets' ) unless File.directory?( 'assets' )
    
    source = File.expand_path "#{File.dirname(__FILE__)}/../assets/"
    dest   = "./assets/"
    
    puts "Copying '#{source} ' to '#{dest}'"     
    
    Dir.glob(source+"/*.*").each do |f|
       if not File.exists?(File.expand_path(dest+ File.basename(f)))
         puts "Copying #{f}"
         FileUtils.cp(File.expand_path(f), dest)
       else
         puts "Skipped #{f}"
       end
    end

  end

  # Print usage message.
  def self.usage
    puts "Hello! To render the slide show just type gary.
To add the assets folder just type, gary --assets.
BYE"
    puts Albino.new('class New; end', :ruby).colorize
    puts "woot"
  end

  # Build de presentation slides.
  class Builder < Markaby::Builder
    attr_reader :presentation_options
    
    # Render the slideshow HTML.
    def render
      to_s
    end

1    # Create a presentation with all slides, headers, controls etc.
    # You must pass the presentation title.
    def presentation(options = {}, &block)
      raise "Must have a title" unless options.has_key? :title

      @presentation_options = options
      html do
        head do
          meta :name=>"defaultView", :content=>"slideshow"
          link.outlineStyle! :rel => 'stylesheet', :type => 'text/css',
          :href => 'assets/outline.css', :media => 'screen'
          link.slideStyle! :rel => 'stylesheet', :type => 'text/css',
          :href => '/print.css', :media => 'print'
          link.slideProj! :rel => 'stylesheet', :type => 'text/css',
          :href => 'assets/style.css', :media => 'projection'
          link :rel => 'stylesheet', :type => 'text/css',
          :href => 'assets/prettify.css', :media => 'screen'
          
          script :src => "assets/jquery.js", :type => "text/javascript"
          script :src => "assets/slides.js", :type => "text/javascript"
          script :src => "assets/gary.js", :type => "text/javascript"          
          
          title @presentation_options[:title]
        end
        body do
          
          div.layout! do
            div.controls! { }
            div.currentSlide! { }
            div.header! { }
            div.footer! do
              h1  @presentation_options[:title]
            end
            div.microsoft! do
              self << "Microsoft's Internet Explorer browser
            has no built-in vector graphics machinery
             required for \"loss-free\" gradient background themes."
            end
          end
          
          div.presentation do
            instance_eval(&block)
          end
        end
      end            
    end
    
    # Create a slide, you can pass some options, same options accepted by "div" tag.
    def slide(options = {}, &block)
      div.slide options do
        div.container { instance_eval(&block) }
      end
    end
    
    # Generates synta hightlight for code using albino
    def code(options = {})
      self << Albino.new(options[:code], options[:type]).colorize
    end
    
  end
end
