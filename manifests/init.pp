# Manage the Gitlab configuration.
# GitLab is a web-based Git repository manager with wiki, CI and issue tracking
# features.

# Do not put anything here (except inclusions of other classes) because this
# class is inherited.

class gitlab(
    String  $api_token       = 'changeme',
    Array   $puppet_masters  = [ 'puppet01.example.com' ],
    String  $gitlab_endpoint = 'https://gitlab.example.com/api/v4',
    Integer $gitlab_puppet_modules_group_id = 42,
    String  $gitlab_puppet_module_namespace = 'puppet_modules',
    String  $gitlab_puppet_env_namespace    = 'puppet',
    String  $gitlab_puppet_env_project      = 'environments',
    String  $puppetmaster_deploy_user       = 'githook',
    ) {

    include gitlab::cli
    include gitlab::hooks

}
