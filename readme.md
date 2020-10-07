# Module puppet pour gitlab

## Aperçu

Configuration de gitlab, en particulier pour des hooks r10k et puppet.

_GitLab is a web-based Git repository manager with wiki, CI and issue tracking
features._


## Hooks personnalisés

Basés sur https://github.com/drwahl/puppet-git-hooks

Avec des modifications (notamment pour gérer le nouveau mode hashed
storage de gilab).


## Installation de r10k sur les puppet masters

_R10K provides a general purpose toolset for deploying Puppet environments and modules._

```bash
gem install r10k
useradd githook
mkdir -p /etc/r10k
mkdir -p /var/cache/r10k
cat<<EOF>/etc/r10k/r10k.yaml
cachedir: '/var/cache/r10k'
:sources:
  :gitlab:
     remote: git@gitlab.example.com:puppet/environments.git
     basedir: /etc/puppetlabs/code/environments
EOF
chown githook: /var/cache/r10k
chown -R githook: /etc/puppetlabs/code/environments
chmod 775 /etc/puppetlabs/code/environments
usermod -a -G githook puppet
```

## Clefs ssh entre gitlab et les puppet masters

Il faut créer avec ssh-keygen

- une paire de clefs pour la connexion de gitlab vers le(s) puppet
master(s) afin de lancer le rafraîchissement des environnements via des hooks.

- une paire de clef pour la connexion au gitlab depuis les puppet masters,
  utilisée par r10k (cette clef est à référencer dans les projets gitlab comme
  _deploy key_)

Coté gitlab :

```
/var/opt/gitlab/.ssh/id_rsa  # clef utilisée pour ssh githook@<puppet master>
/var/opt/gitlab/.ssh/id_rsa.pub
/var/opt/gitlab/.ssh/known_hosts
```

`/var/opt/gitlab` est le home directory de l'utilisateur git

Coté puppet(s) master(s) :

```
/home/githook/.ssh/id_rsa          # clef utilisée par le client git
/home/githook/.ssh/id_rsa.pub
/home/githook/.ssh/authorized_keys # référençant id_rsa.pub de git@<serveur gitlab>
/home/githook/.ssh/known_hosts
```

<div style="page-break-after: always;"></div>

Initialiser le known_hosts coté gitlab comme suit :

```
su - git
ssh githook@<serveur puppet>
```

Initialiser le known_hosts coté puppet master(s) comme suit :

```
su - githook
ssh git@<serveur gitlab>
```

