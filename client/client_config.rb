RRRSpec.configure do |conf|
  conf.redis = {
    host: ENV['REDIS_HOST'],
  }
end

RRRSpec.configure(:client) do |conf|
  conf.rsync_remote_path = "#{ENV['MASTER_HOST']}:/tmp/rrrspec-rsync"
  conf.rsync_options = [
    '--compress',
    '--times',
    '--recursive',
    '--links',
    '--perms',
    '--inplace',
    '--delete',
    '--exclude=tmp',
  ].join(' ')
  conf.packaging_dir = `git rev-parse --show-toplevel`.strip
  conf.spec_files = lambda do
    Dir.chdir(conf.packaging_dir) do
      Dir['spec/**{,/*/**}/*_spec.rb'].uniq
    end
  end
  conf.setup_command = <<-END
    bundle install
  END
  conf.slave_command = <<-END
    bundle exec rrrspec-client slave
  END
  conf.worker_type = 'default'
  conf.taskset_class = 'flowci-test'
  conf.max_workers = 3
  conf.max_trials = 3
  conf.unknown_spec_timeout_sec = 5
  conf.least_timeout_sec = 5
end
