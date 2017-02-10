module Fluent
  module KinesisHelper
    class CredentialProviderChain < Aws::CredentialProviderChain
      def providers
        [
          [:static_credentials, {}],
          [:env_credentials, {}],
          [:assume_role_credentials, {}],
          [:shared_credentials, {}],
          [:instance_profile_credentials, {
             retries: @config ? @config.instance_profile_credentials_retries : 0,
             ip_address: @config ? @config.instance_profile_credentials_ip_address : nil,
             port: @config ? @config.instance_profile_credentials_port : nil,
             http_open_timeout: @config ? @config.instance_profile_credentials_timeout : 1,
             http_read_timeout: @config ? @config.instance_profile_credentials_timeout : 1,
           }],
        ]
      end
    end
  end
end
