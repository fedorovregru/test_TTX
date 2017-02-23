# Класс "Член экипажа"
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
	die "ФИО должно быть в три слова, через пробел!\n"
	    if $name =~ m/::fio$/ && !( $value =~ m/^\w+\s\w+\s\w+$/ );
	
	# проверка валидности поля rank
	die "Звание должно быть в одно слово!\n"
	    if $name =~ m/::rank$/ && !( $value =~ m/^\w+$/ );
	
	# проверка валидности поля profession
	die "Специальность может быть только следующей:\n"
	    . "командир, механик-водитель, наводчик, заряжающий, радист!\n"
	if $name =~ m/::profession$/
	   && !( $value =~ m/^(командир|механик-водитель|наводчик|заряжающий|радист)$/ );
	
	# проверка валидности поля service_time
	die "Срок службы должен быть цифрой!\n"
	    if $name =~ m/::service_time$/ && !( $value =~ m/^\d+$/ );
	
	return $self->{$name} = $value;
}

return 1;
