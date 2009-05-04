require 'rake/clean'

task :clean do
  Dir.chdir("greed") do
    sh "rake clean"
  end
end

task :clobber do
  Dir.chdir("greed") do
    sh "rake clobber"
  end
end

ZIP_FILE = 'pkg/refactor.zip'
TAR_FILE = 'pkg/refactor.tar'
APP_DIR = 'greed'

directory "pkg"

file ZIP_FILE => [:clobber, "pkg"] do
  sh "zip -r #{ZIP_FILE} #{APP_DIR}/*"
end

task :package => [:clobber, ZIP_FILE]

