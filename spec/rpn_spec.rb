require 'spec_helper'

def run(input)
  IO.popen('ruby bin/rpn 2> /dev/null', 'r+') do |stdio|
    stdio.write input + "\n"
    stdio.close_write
    return stdio.read.strip
  end
end

describe 'The rpn command line utility' do
  it 'gives the correct output' do
    run("5\n1 2 + 4 * + 3 -").should == "5.0\n14.0"
  end

  it "continues with subsequent expressions after an error, and doesn't write errors to stdout" do
    run("+\n1").should == '1.0'
  end

  it 'exits on q input' do
    run("q\n1").should be_empty
  end
end
