set terminal epslatex color size 10.5cm,6cm font "" 8
set encoding utf8

set output "fig-load.tex"
set xlabel 'Время'
unset xtics
set ylabel 'Нагрузка' offset 3,0
set ytics ('0' 0, 'Низкая' 7.5, 'Средняя' 15, 'Высокая' 22.5, 'Экстра' 30)
set samples 200
set key top left width 1 height 1 box

# smoothstep
_smoothstep(x) = (x < 0.0) ? 0.0 : ( (x > 1.0) ? 1.0 : x * x * (3.0 - 2.0 * x) )
smoothstep(lo, hi, x) = _smoothstep((x - lo) / (hi - lo))

# Medium constant load
load(x) = 14.5 + rand(0)
# Stress load
stress(x) = 22.0 * (smoothstep(0.1, 0.3, x) - smoothstep(0.7, 0.9, x))
# Soak load
soak(x) = 15.0 * smoothstep(0.1, 0.3, x) * (1.0 + 0.8 * x)
# Spike load
spike(x) = 30.0 * (smoothstep(0.42, 0.5, x) - smoothstep(0.5, 0.58, x))


plot [0:1][0:30] load(x) ls 1 lc rgb 'gray' title '1', \
	stress(x) ls 1 lc rgb 'green' title '2', \
	soak(x) ls 1 lc rgb 'blue' title '3', \
	spike(x) ls 1 lc rgb 'red' title '4'

set terminal epslatex color size 21cm,12cm font "" 17
set output "fig-load-a4.tex"
set ylabel 'Нагрузка' offset 5,0

plot [0:1][0:30] load(x) ls 1 lc rgb 'gray' title '1', \
	stress(x) ls 1 lc rgb 'green' title '2', \
	soak(x) ls 1 lc rgb 'blue' title '3', \
	spike(x) ls 1 lc rgb 'red' title '4'

