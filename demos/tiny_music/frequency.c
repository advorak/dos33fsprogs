#include <stdio.h>

double frequencies[8][12]={
{ 32.703,  34.648,  36.708,  38.891,  41.203,  43.654,
  46.249,  48.999,  51.913,  55.000,  58.270,  61.735,},
{ 65.406,  69.296,  73.416,  77.782,  82.406,  87.308,
  92.498,  97.998, 103.826, 110.000, 116.540, 123.470,},
{130.812, 138.592, 146.832, 155.564, 164.812, 174.616,
 184.996, 195.996, 207.652, 220.000, 233.080, 246.940,},
{261.624, 277.184, 293.664, 311.128, 329.624, 349.232,
 369.992, 391.992, 415.304, 440.000, 466.160, 493.880,},
{523.248, 554.368, 587.328, 622.256, 659.248, 698.464,
 739.984, 783.984, 830.608, 880.000, 932.320, 987.760,},
{1046.496,1108.736,1174.656,1244.512,1318.496,1396.928,
 1479.968,1567.968,1661.216,1760.000,1864.640,1975.520,},
{2092.992,2217.472,2349.312,2489.024,2636.992,2793.856,
 2959.936,3125.936,3322.432,3520.000,3729.280,3951.040,},
{4185.984,4434.944,4698.624,4978.048,5273.984,5587.712,
 5919.872,6271.872,6644.864,7040.000,7458.560,7902.080}};

#define FREQUENCY 1023000.0

int main(int argc, char **argv) {

	int n,o;

	for(o=1;o<9;o++) {
		for(n=0;n<12;n++) {
		//	printf("%d %d: %lf $%04X\n",n,o,
		//		frequencies[o-1][n],
		//		(int)((FREQUENCY/frequencies[o-1][n])/16.0));
			printf("$%02X,",
				(int)((FREQUENCY/frequencies[o-1][n])/16.0));

		}
		printf("\n");
	}
	return 0;
}
