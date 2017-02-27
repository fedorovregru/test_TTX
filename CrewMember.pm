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

    # проверяем значение поля если имеется $value
    if ( $value ) {
        
        # хеш для валидации значений
        my %fields_validation_hash = (
            fio          => '^\w+\s\w+\s\w+$',
            rank         => '^\w+$',
            profession   => '^(командир|механик-водитель|наводчик|заряжающий|радист)$',
            service_time => '^\d+$',
            vehicle_type => '.+'
        );

        # проверка валидности поля
        $name =~ m/::(\w+)$/;
        my $regexp = $fields_validation_hash{$1};
        die "Попытка записи некорректных данных в поле $1!\n"
            unless $value =~ m/$regexp/;

        return $self->{$name} = $value;
    }

    return $self->{$name};
}

return 1;
