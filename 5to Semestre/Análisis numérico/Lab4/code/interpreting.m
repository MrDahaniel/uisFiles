%{
    Para determinar la función f(t) que permita determinar el valor del tiempo cuando el proyectil toca nuevamente en suelo, tenemos que partir de la función que describe la altura que este toma respecto al tiempo, es decir y(t).

    De esto, tenemos que determinar el valor de la segunda raíz perteneciente a la función con los valores dados. Entonces, la función f(t) para cuando el proyectil estará en el suelo nuevamente, sería:

    f(t) = (1600*sin(50)+3200)*(1-e^((-t)/(10)))-320*t = 0

    Nota: La función es trabajada en grados.
%}

% Función f(t)
f = @(t) (1600*sin((50*pi)/180)+3200)*(1-exp((-t)/(10)))-320*t;

% Valores inciales
a = 5;
b = 10;

% iteraciones
iter = 10;

% Ejecución

secantRoot(f,a,b,iter)