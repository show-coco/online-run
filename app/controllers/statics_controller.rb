class StaticsController < ApplicationController
  def index
    @code = session[:code]
    @text = session[:text]
  end

  def create
    File.open("docker/test.rb", "w") do |f|
      f.puts(params[:code])
    end

    cmd1 = "echo 'FROM ruby 
    COPY test.rb test.rb 
    WORKDIR result 
    RUN touch result.txt
    CMD [\"/bin/sh\", \"-c\", \"ruby ../test.rb > result.txt 2>&1\"]' > ~/sample-app/docker/Dockerfile"
    cmd2 = "docker build -t ruby-image1 ~/sample-app/docker"
    cmd3 = "docker run -v vol1:/result --name ruby-container1 -it ruby-image1"
    cmd4 = "sudo cat /var/lib/docker/volumes/vol1/_data/result.txt > ~/sample-app/docker/result2.txt"
    cmd5 = "docker container rm ruby-container1"
    cmd6 = "docker image rm ruby-image1"
   
    system(cmd1)
    system(cmd2)
    system(cmd3)
    system(cmd4)
    system(cmd5)
    system(cmd6)

    f = File.open("docker/result2.txt")
     text = f.read
    f.close

    session[:text] = text
    session[:code] = params[:code]
    redirect_to root_path
  end
end
