# Class: tomcat
#
# This is the main tomcat class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, tomcat class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $tomcat_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, tomcat main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $tomcat_source
#
# [*source_dir*]
#   If defined, the whole tomcat configuration direrctory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $tomcat_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $tomcat_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, tomcat main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $tomcat_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $tomcat_options
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $tomcat_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $tomcat_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $tomcat_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $tomcat_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for tomcat checks
#   Can be defined also by the (top scope) variables $tomcat_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ip_address
#   Can be defined also by the (top scope) variables $tomcat_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $tomcat_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $tomcat_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $tomcat_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for tomcat port(s)
#   Can be defined also by the (top scope) variables $tomcat_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling tomcat. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $tomcat_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $tomcat_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $tomcat_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $tomcat_audit_only
#   and $audit_only
#
# Default class params - As defined in tomcat::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of tomcat package
#
# [*service*]
#   The name of tomcat service
#
# [*service_status*]
#   If the tomcat service init script supports status argument
#
# [*process*]
#   The name of tomcat process
#
# [*process_args*]
#   The name of tomcat arguments.
#   Used only in case the tomcat process name is generic (java, ruby...)
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $tomcat_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $tomcat_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include tomcat"
# - Call tomcat as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class tomcat (
  $my_class          = $tomcat::params::my_class,
  $source            = $tomcat::params::source,
  $source_dir        = $tomcat::params::source_dir,
  $source_dir_purge  = $tomcat::params::source_dir_purge,
  $template          = $tomcat::params::template,
  $options           = $tomcat::params::options,
  $absent            = $tomcat::params::absent,
  $disable           = $tomcat::params::disable,
  $disableboot       = $tomcat::params::disableboot,
  $monitor           = $tomcat::params::monitor,
  $monitor_tool      = $tomcat::params::monitor_tool,
  $monitor_target    = $tomcat::params::monitor_target,
  $puppi             = $tomcat::params::puppi,
  $puppi_helper      = $tomcat::params::puppi_helper,
  $firewall          = $tomcat::params::firewall,
  $firewall_tool     = $tomcat::params::firewall_tool,
  $firewall_src      = $tomcat::params::firewall_src,
  $firewall_dst      = $tomcat::params::firewall_dst,
  $debug             = $tomcat::params::debug,
  $audit_only        = $tomcat::params::audit_only,
  $package           = $tomcat::params::package,
  $service           = $tomcat::params::service,
  $service_status    = $tomcat::params::service_status,
  $process           = $tomcat::params::process,
  $process_args      = $tomcat::params::process_args,
  $config_dir        = $tomcat::params::config_dir,
  $config_file       = $tomcat::params::config_file,
  $config_file_mode  = $tomcat::params::config_file_mode,
  $config_file_owner = $tomcat::params::config_file_owner,
  $config_file_group = $tomcat::params::config_file_group,
  $config_file_init  = $tomcat::params::config_file_init,
  $pid_file          = $tomcat::params::pid_file,
  $data_dir          = $tomcat::params::data_dir,
  $log_dir           = $tomcat::params::log_dir,
  $log_file          = $tomcat::params::log_file,
  $port              = $tomcat::params::port,
  $protocol          = $tomcat::params::protocol
  ) inherits tomcat::params {

  validate_bool(  $source_dir_purge ,
                  $absent ,
                  $disable ,
                  $disableboot ,
                  $monitor ,
                  $puppi ,
                  $firewall ,
                  $debug ,
                  $audit_only )

  ### Definition of some variables used in the module
  $manage_package = $tomcat::absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_service_enable = $tomcat::disableboot ? {
    true    => false,
    default => $tomcat::disable ? {
      true    => false,
      default => $tomcat::absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $tomcat::disable ? {
    true    => 'stopped',
    default =>  $tomcat::absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_file = $tomcat::absent ? {
    true    => 'absent',
    default => 'present',
  }

  # If $tomcat::disable == true we dont check tomcat on the local system
  if $tomcat::absent == true or $tomcat::disable == true or $tomcat::disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $tomcat::absent == true or $tomcat::disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $tomcat::audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $tomcat::audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $tomcat::source ? {
    ''        => undef,
    default   => $tomcat::source,
  }

  $manage_file_content = $tomcat::template ? {
    ''        => undef,
    default   => template($tomcat::template),
  }

  ### Managed resources
  package { 'tomcat':
    ensure => $tomcat::manage_package,
    name   => $tomcat::package,
  }

  service { 'tomcat':
    ensure     => $tomcat::manage_service_ensure,
    name       => $tomcat::service,
    enable     => $tomcat::manage_service_enable,
    hasstatus  => $tomcat::service_status,
    pattern    => $tomcat::process,
    require    => Package['tomcat'],
    subscribe  => File['tomcat.conf'],
  }

  file { 'tomcat.conf':
    ensure  => $tomcat::manage_file,
    path    => $tomcat::config_file,
    mode    => $tomcat::config_file_mode,
    owner   => $tomcat::config_file_owner,
    group   => $tomcat::config_file_group,
    require => Package['tomcat'],
    notify  => Service['tomcat'],
    source  => $tomcat::manage_file_source,
    content => $tomcat::manage_file_content,
    replace => $tomcat::manage_file_replace,
    audit   => $tomcat::manage_audit,
  }

  # The whole tomcat configuration directory can be recursively overriden
  if $tomcat::source_dir {
    file { 'tomcat.dir':
      ensure  => directory,
      path    => $tomcat::config_dir,
      require => Class['tomcat::install'],
      source  => $source_dir,
      recurse => true,
      purge   => $source_dir_purge,
      replace => $tomcat::manage_file_replace,
      audit   => $tomcat::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $tomcat::my_class {
    include $tomcat::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $tomcat::puppi == true {
    $puppivars=get_class_args()
    file { 'puppi_tomcat':
      ensure  => $tomcat::manage_file,
      path    => "${settings::vardir}/puppi/tomcat",
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      require => Class['puppi'],
      content => inline_template('<%= puppivars.to_yaml %>'),
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $tomcat::monitor == true {
    monitor::port { "tomcat_${tomcat::protocol}_${tomcat::port}":
      protocol => $tomcat::protocol,
      port     => $tomcat::port,
      target   => $tomcat::params::monitor_target,
      tool     => $tomcat::monitor_tool,
      enable   => $tomcat::manage_monitor,
    }
    monitor::process { 'tomcat_process':
      process  => $tomcat::process,
      service  => $tomcat::service,
      pidfile  => $tomcat::pid_file,
      tool     => $tomcat::monitor_tool,
      enable   => $tomcat::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $tomcat::firewall == true {
    firewall { "tomcat_${tomcat::protocol}_${tomcat::port}":
      source      => $tomcat::firewall_source,
      destination => $tomcat::firewall_destination,
      protocol    => $tomcat::protocol,
      port        => $tomcat::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $tomcat::firewall_tool,
      enable      => $tomcat::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $tomcat::debug == true {
    file { 'debug_tomcat':
      ensure  => $tomcat::manage_file,
      path    => "${settings::vardir}/debug-tomcat",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}