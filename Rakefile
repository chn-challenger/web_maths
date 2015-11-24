require 'rake4latex'
#Needed for some actions without a previous TeX-call
task :basefile => 'testdocument.tex'
#We want to build a PDF
file 'testdocument.pdf' => 'testdocument.tex'

#Force the compilation
task :touch => 'testdocument.tex'

#Define the default tasks
task :default => :touch
task :default => 'testdocument.pdf'
task :default => :statistic
task :default => :clean

#Make the rakefile self-executable
if $0 == __FILE__
  app = Rake.application
  app[:default].invoke
end
