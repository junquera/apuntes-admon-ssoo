OUTPUT_NAME="ssoo"

# SESIONS=$(echo S{0..3}.md)
SESIONS = S0.md S1.md S2.md S3.md
EXTRAS = T1.md

all:
	pandoc ${SESIONS} ${EXTRAS} -o ${OUTPUT_NAME}.pdf
