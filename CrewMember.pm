package CrewMember;

use utf8;

my %PROPERTIES = (
	'CrewMember::fio'          => '',
	'CrewMember::rank'         => '',
	'CrewMember::profession'   => '',
	'CrewMember::service_time' => '',
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
	
	my ( $self, $value ) = @_;
	
	my $name = our $AUTOLOAD;
	
	# выход из метода если вызвал не объект класса
	exit unless ref($self);
	# выход из метода если вызван метод DESTROY
	return if $name =~ m/::DESTROY$/;
	
	# отдаем значение поля если нет входных параметров
	return $self->{$name} unless $value;
	
	# проверка валидности поля fio
	if ( $name =~ m/::fio$/ && !( $value =~ m/^\w+\s\w+\s\w+$/ ) ) {
		print "ФИО должно быть в три слова, через пробел.\n";
		return $self->{$name};
	}
	
	# проверка валидности поля rank
	if ( $name =~ m/::rank$/ && !( $value =~ m/^\w+$/ ) ) {
		print "Звание должно быть в одно слово.\n";
		return $self->{$name};
	}
	
	# проверка валидности поля profession
	if ( $name =~ m/::profession$/
	         && !( $value =~ m/^(командир|механик-водитель|наводчик|заряжающий|радист)$/ ) ) {
		print "Специальность может быть только следующей:\n";
		print "командир, механик-водитель, наводчик, заряжающий, радист.\n";
		return $self->{$name};
	}
	
	# проверка валидности поля service_time
	if ( $name =~ m/::service_time$/ && !( $value =~ m/^\d+$/ ) ) {
		print "Срок службы должен быть цифрой.\n";
		return $self->{$name};
	}
	
	return $self->{$name} = $value;
}


return 1;
