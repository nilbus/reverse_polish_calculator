guard :rspec, cli: '--format documentation --color' do
  watch('spec/spec_helper.rb')    { "spec" }
  watch(%r{^lib/(.+)\.rb$})       { |m| "spec/#{m[1]}_spec.rb" }
  watch('bin/rpn')                { "spec/rpn_spec.rb" }
  watch(%r{^spec/(.+)_spec\.rb$}) { |m| m }
end
