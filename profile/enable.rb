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

module Fluent
  module KinesisHelper
    module Initialize
      def start
        super
        require 'ruby-prof'
        RubyProf.measure_mode = RubyProf::CPU_TIME
        RubyProf.start
      end

      def shutdown
        super
        result = RubyProf.stop
        file = File.join('profile', ENV["TYPE"]+".profile")
        File.open(file, 'w') { |f|
          RubyProf::FlatPrinter.new(result).print(f)
        }
      end
    end
  end
end
