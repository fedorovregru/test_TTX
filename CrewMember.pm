package CrewMember;

my %PROPERTIES = (
	'CrewMember::fio'          => '',
	'CrewMember::rank'         => '',
	'CrewMember::profession'   => '',
	'CrewMember::service_time' => '0',
	'CrewMember::vehicle_type' => ''
);

use subs qw(fio rank profession service_time vehicle_type);

sub new {
	
	my ( $invocant ) = @_;
	
	my $class = ref($invocant) || $invocant;
	my $self  = { %PROPERTIES, @_ };
	
	return bless $self, $class;
}

sub AUTOLOAD {
	
	my $self = shift;
	
	exit unless ref($self);
	my $name = our $AUTOLOAD;
	return if $name =~ m/::DESTROY$/;
	
	if (@_) {
		return $self->{$name} = shift;
	}
	else {
		return $self->{$name};
	}
}

return 1;
