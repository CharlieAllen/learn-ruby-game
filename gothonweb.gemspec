lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
	spec.name 			= "gothonweb"
	spec.version 		= '1.0'
	spec.authors		= ['Charlie Allen'] 
	spec.email			= ['Your email goes here']
	spec.summary		= %q{short summary of your project}
	spec.description	= %q{Longer description of your project}
	spec.homepage		= "http://yourprojectpage.com"
	spec.license		= "MIT"

	spec.files			= ['lib/gothonweb.rb']
	spec.executables	= ['bin/gothonweb']
	spec.test_files		= ['tests/test_gothonweb.rb']
	spec.require_paths	= ["lib"]
end

