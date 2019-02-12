class Script_from_maven
  def hello
    puts 'Hello!'
    putst ENV['JAVA_HOME']
  end
end

s = Script_from_maven.new
s.hello
