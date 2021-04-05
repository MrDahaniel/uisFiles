datosPlanetarios = [87.97 57.91e6;
                    224.70 108.70e6;
                    365.26 149.60e6;
                    686.98 227.92e6;
                    4332.59 778.57e6;
                    10759.22 1433.53e6;
                    30685.40 2872.46e6;
                    60189.00 4495.06e6;];

datosAlterados = [log(datosPlanetarios(:,2).^3), log(datosPlanetarios(:,1).^2)];

lsquare(datosAlterados)

