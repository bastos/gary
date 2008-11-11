# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gary}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tiago Bastos"]
  s.date = %q{2008-11-11}
  s.default_executable = %q{gary}
  s.description = %q{A Web Presentation Creator with Markaby}
  s.email = %q{comechao@gmail.com}
  s.executables = ["gary"]
  s.extra_rdoc_files = ["bin/gary", "lib/gary.rb", "README.rdoc"]
  s.files = ["bin/gary", "lib/gary.rb", "Manifest", "Rakefile", "assets/style.css", "assets/outline.css", "assets/slides.css", "assets/jquery.js", "assets/slides.js", "assets/print.css", "README.rdoc", "examples/test.rb", "gary.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/bastos/gary}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Gary", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{gary}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A Web Presentation Creator with Markaby}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<markaby>, [">= 0"])
    else
      s.add_dependency(%q<markaby>, [">= 0"])
    end
  else
    s.add_dependency(%q<markaby>, [">= 0"])
  end
end
