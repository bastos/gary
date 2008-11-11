# -*- coding: utf-8 -*-

$:.unshift File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'markaby'
require 'fileutils'
require 'ftools'

# Gary Presentation Builder
# JS and part of the CSS from http://slideshow.rubyforge.org/
module Gary 
  
  def self.main(args)
    if not args[0]
      self.usage 
    elsif args[0] == '--assets'
      self.create_assets
    else args[0] == '--render' or args[0] == '-r'
      raise "File #{args[1]} don't exists!" unless File.exists?(args[1])
      f = File.expand_path "#{args[1]}"
      puts "Creating slideshow for #{f}"
      slideshow = Gary::Builder.new
      slideshow_file = f.gsub(/\.rb$/, '')
      out = File.new( "#{slideshow_file}.html", "w+" )
      out << slideshow.instance_eval(File.new(f).read, f)    
      out.flush
      out.close
    end
  end
  
  def self.create_assets
    Dir.mkdir( 'assets' ) unless File.directory?( 'assets' )
    
    source = File.expand_path "#{File.dirname(__FILE__)}/../assets/"
    dest   = "./"
    
    puts "copying '#{source} ' to '#{dest}'"     
    FileUtils.cp_r( source, dest )
  end

  def self.usage
    puts "To render the slide show just type gary.
To add the assets folder just type, gary --assets.
BYE"
  end

  # Build de presentation slides, must be rendered by #Render
  class Builder < Markaby::Builder
    attr_reader :presentation_options
    
    def render
      to_s
    end

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
          
          script :src => "assets/jquery.js", :type => "text/javascript"
          script :src => "assets/slides.js", :type => "text/javascript"
          
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
    
    def slide(options = {}, &block)
      div.slide options do
        instance_eval(&block) 
      end
    end
    
  end
end
