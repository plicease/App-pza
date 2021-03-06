use strict;
use warnings;
use 5.020;
use Test2::Plugin::FauxHomeDir;
use Test::More tests => 11;
use lib 'inc';
use Mock;
use App::pza;

my $app = App::pza->new(dbs_class => 'Database::Server::Foo');
isa_ok $app, 'App::pza';

is $app->dbs_class, 'Database::Server::Foo', 'app.dbs_class';
is $app->dbs_config->{foo}, 'bar', 'app.dbs_config';
ok -f $app->dbs_config_file, 'app.dbs_config_file';
isa_ok $app->dbs, 'Database::Server::Foo';
is $app->exit_value, 0, 'app.exit_value';
is $app->dbs->foo, 'bar', 'app.dbs.foo';

is $app->dbs->is_up, 0, 'app.dbs.is_up';

$app->start_unless_up;
is $app->dbs->is_up, 1, 'app.start_unless_up';

isa_ok(App::pza->get_dbs("Foo"), 'Database::Server::Foo');
isa_ok(App::pza->get_dbs("Database::Server::Foo"), 'Database::Server::Foo');

