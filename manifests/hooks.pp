# Deploy some custom hooks in some gitlab projects (puppet modules, for a
# start)

class gitlab::hooks inherits gitlab {

    # Some defaults
    $filedefaults = {
        ensure => directory,
        mode   => '0755',
        owner  => 'root',
        group  => 'root',
    }

    file {
        default: * => $filedefaults;

        '/var/opt/gitlab':;

        '/var/opt/gitlab/.puppetlabs':
            owner => 'git',;

        '/var/opt/gitlab/custom_hooks':
            recurse => true,
            purge   => false,
            source  => 'puppet:///modules/gitlab/custom_hooks',;

        '/var/opt/gitlab/custom_hooks/puppet/post-receive':
            ensure  => present,
            content => template('gitlab/post-receive'),;

        '/usr/local/bin/deploy_hooks.rb':
            ensure    => present,
            content   => template('gitlab/deploy_hooks.rb.erb'),
            show_diff => false,;
    }

    cron { 'Deploy some hooks in gitlab projects':
        command => '/usr/local/bin/deploy_hooks.rb',
        user    => 'root',
        minute  => '*/10',
        hour    => '*',
    }

}
