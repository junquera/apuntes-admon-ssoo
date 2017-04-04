OUTPUT_NAME="ssoo"

# SESIONS=$(echo S{0..3}.md)

S0:
	cat S0.md > res.md

S1:
	cat S1.md >> res.md

S2:
	cat S2.md >> res.md

S3:
	cat S3.md >> res.md

S4:
	cat S4.md >> res.md

S5:
	cat S5.md >> res.md

S6_TEMA:
	cat S6.md >> S6_tmp.md

S6_EJERCICIOS:
	cat ejercicios.txt ejercicio1.sh

S6: S6_TEMA S6_EJERCICIOS
	cat S6_tmp.md >> res.md

S7:
	cat S7.md >> res.md

S8_TEMA:
	cat S8.md >> S8_tmp.md

S8: S8_TEMA
	cat S8_tmp.md >> res.md

S9:
	cat S9.md >> res.md

EXTRAS_1:
	cat T1.md >> res.md

all: S1 S2 S3 S4 S5 S6 S7 S8 S9
	pandoc ${SESIONS} ${EXTRAS} -o ${OUTPUT_NAME}.pdf

teoria: S1 S2 S3 S4 S5 S6_TEMA S8_TEMA S9_TEMA
	pandoc res.md -O ${OUTPUT_NAME}.pdf

clean:
	rm '*_tmp.md' res.md
