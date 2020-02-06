FROM ruby 
    COPY test.rb test.rb 
    WORKDIR result 
    RUN touch result.txt
    CMD ["/bin/sh", "-c", "ruby ../test.rb > result.txt 2>&1"]
