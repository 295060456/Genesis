# MacOS elasticsearch

[TOC]

## 1、使用`brew` 安装 `elasticsearch`

*相关资料*

[CSDN/Mac安装ES：elasticsearch has been deprecated，incompatible license，no bottle available!](https://blog.csdn.net/lilyssh/article/details/119646563)

**注意：brew install elasticsearch 已被弃用**

```ruby
brew install elastic/tap/elasticsearch-full
```

```bash
➜  ~ brew list elastic/tap/elasticsearch-full      
Warning: Calling plist_options is deprecated! Use service.require_root instead.
Please report this issue to the elastic/tap tap (not Homebrew/brew or Homebrew/homebrew-core), or even better, submit a PR to fix it:
  /opt/homebrew/Library/Taps/elastic/homebrew-tap/Formula/elasticsearch-full.rb:68

/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-certgen
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-certutil
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-cli
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-croneval
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-env
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-env-from-file
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-geoip
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-keystore
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-migrate
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-node
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-plugin
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-saml-metadata
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-service-tokens
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-setup-passwords
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-shard
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-sql-cli
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-syskeygen
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/elasticsearch-users
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/x-pack-env
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/x-pack-security-env
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/bin/x-pack-watcher-env
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/homebrew.mxcl.elasticsearch-full.plist
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/libexec/bin/ (23 files)
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/libexec/jdk.app/ (432 files)
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/libexec/lib/ (45 files)
/opt/homebrew/Cellar/elasticsearch-full/7.17.4/libexec/modules/ (418 files)
```

