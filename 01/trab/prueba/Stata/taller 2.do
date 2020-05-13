***************************************
**** Segunda sesión de clase de TICs***
***************************************

clear all
use "D:\MICROECONOMETRIA CON STATA 2020 PARA ENSEÑAR\Salarios.dta"
*mostrando los datos
edit
* aplicando el comando rename
rename Salario salario
*etiquitar las variables label var
label var salario "salarios en miles de soles para Junín"
label var educ "años de educación"
label var exper "años de experiencia"
*generando datos
generate lsalario=log(salario)
label var lsalario "logaritmo de salario"
gen expersq=exper^2
label var expersq "años de experiencia al cuadrado"
gen educsq=educ^2
label var educsq "años de educacion al cuadrado"
* utilizando el comando egen es una extension de gen
egen med_salario=mean(salario)
label var med_salario "media de salario"
egen stdsalario = std(salario)
gen desv=salario-med_salario
* generando un dummy
gen dummy=1 if educ>=14
replace dummy=0 if dummy==.

*regresion
reg lsalario educ exper

* histograma
histogram salario, normal kdensity kdenopts(lcolor(red)) legend(on) saving(gr5, replace)
* grafico
twoway (scatter salario educ)(lfit salario educ), title(Salarios vs Educación) subtitle(Gráfico de dispersión con ajuste lineal) //
caption(Fuente: Cálculos propios) note(Ejemplo twoway) xtitle(Años de educación) ytitle(Salarios) saving(gr2, replace) 
