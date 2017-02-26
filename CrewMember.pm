# Класс "Член экипажа"
package CrewMember;

use utf8;

sub new {
	
	my ( $invocant ) = @_;
	
	my $class = ref($invocant) || $invocant;
	my $self  = { { fio          => '',
		            rank         => '',
		            profession   => '',
		            service_time => '',
		            vehicle_type => '' }, @_ };
	
	return bless $self, $class;
}

sub AUTOLOAD {
	
	my ( $self, $value ) = @_;
	
	my $name = our $AUTOLOAD;
    
	# выход из метода если вызвал не объект класса
	die "Доступ возможен только объекту класса!" unless ref($self);
	
	# выход из метода если вызван метод DESTROY
	return if $name =~ m/::DESTROY$/;
	
	# отдаем значение поля если нет входных параметров
	return $self->{$name} unless $value;
	
	# хеш для валидации значений
	my %fields_validation_hash = (
		CrewMember::fio          => '^\w+\s\w+\s\w+$',
		CrewMember::rank         => '^\w+$',
		CrewMember::profession   => '^(командир|механик-водитель|наводчик|заряжающий|радист)$',
		CrewMember::service_time => '^\d+$'
	);
	
	# проверка валидности поля
	my $regexp = $fields_validation_hash{$name};
	die "Попытка записи некорректных данных в поле $name!\n"
	    unless $value =~ m/$regexp/;
	
	return $self->{$name} = $value;
}

return 1;
