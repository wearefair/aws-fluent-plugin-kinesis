#
#  Copyright 2014-2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
#  Licensed under the Amazon Software License (the "License").
#  You may not use this file except in compliance with the License.
#  A copy of the License is located at
#
#  http://aws.amazon.com/asl/
#
#  or in the "license" file accompanying this file. This file is distributed
#  on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
#  express or implied. See the License for the specific language governing
#  permissions and limitations under the License.

task :profile do
  conf = profile_conf(ENV["TYPE"])
  pid = spawn("bundle exec fluentd -i '#{conf}' -c profile/dummy.conf -r ./profile/enable")
  sleep 5
  Process.kill("TERM", pid)
  Process.wait
end

def profile_conf(type)
  conf = <<-EOS
<source>
  @type dummy
  tag dummy
  rate 500
</source>

<match dummy>
  @type kinesis_#{type}
  flush_interval 1
  buffer_chunk_limit 1m
  try_flush_interval 0.1
  queued_chunk_flush_interval 0.01

  region ap-northeast-1
  stream_name fluent-plugin-test
</match>
  EOS
  conf
end
