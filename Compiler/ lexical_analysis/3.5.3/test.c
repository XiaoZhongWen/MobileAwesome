float fun(float a, float b) {
	float c = a + b;
	return c;
}

int main(int argc, char *argv[]) {
	float a = 10.0;
	float b = 10.0;
	float c = fun(a, b);
	printf("the value of float c is %f", c);
}
