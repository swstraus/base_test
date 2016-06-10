actions :create
default_action :create

attribute :name,                :kind_of => String, :name_attribute => true
attribute :serverBase,          :kind_of => String, :default => '/data/servers'
attribute :enable,              :kind_of => [TrueClass, FalseClass], :default => true
attribute :start,               :kind_of => [TrueClass, FalseClass], :default => true
attribute :fileChangeRestart,   :kind_of => [TrueClass, FalseClass], :default => true

# User info
attribute :runGroup,            :kind_of => String, :default => 'root'
attribute :runUser,             :kind_of => String, :default => 'root'
#
attribute :restartSubscribes,	:kind_of => Array, :default => node['base_test']['restart_subscribes']
