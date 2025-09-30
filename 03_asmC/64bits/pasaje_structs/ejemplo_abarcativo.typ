= Pasaje de argumentos 64 bits

\

```c
typedef struct {
        int a, b;
        double d;
} structparam;

structparam s;
int e, f, g, h, i, j, k;
long double ld;
double m, n;
__m256 y;

extern void func(int e, int f,
        structparam s,
        int g, int h,
        long double ld,
        double m,
        __m256 y,
        double n,
        int i, int j, int k);

func(e, f, s, g, h, ld, m, y, n, i, j, k);
```

Luego los registros quedan:

#table(columns: 3)[General Purpose Registers][Floating Point Registers][Stack Frame Offset][%rdi: e][%xmm9: s.d][0: ld][%rsi: f][%xmm1: m][16: j][%rdx: s.a, s.b][%xmm2: y][24: k][%rcx: g][%xmm3: n][][%r8: h][][][%r9: i][][]


