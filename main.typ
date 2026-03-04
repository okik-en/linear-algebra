#import "typ/templates/okiken.typ": *
#import "typ/utils/replace.typ": replace
#show: okiken-style.with(progress-char: rotate(45deg, emoji.airplane), title-color-map: color.map.mako)
#show: replace

// 定理環境
#import "theo.typ": *
#show: theo-init

// シンボル
#import "sym.typ": *

// ページ
#set page("a4")

// 各種設定
#set enum(indent: 2em, body-indent: 1em)
#set list(indent: 1em, body-indent: 1em)

// タイトル
#set document(title: "線形代数講座", author: "Salty Lemon", keywords: "線形代数")
#title()

#outline()

#pagebreak()

= 線形空間と線形写像

== 線形空間

はじめに、実数全体の集合を$RR$、複素数全体の集合を$CC$と表すこととしよう。
ただし、ここでは虚数単位を$hat(j)$で表すこととする（工学系の分野では、電流$i(t)$との混同を避けるために$j$や$hat(j)$を用いることが一般的である）。
たとえば、$pi$は$RR$の元であり、$2 hat(j) + 3$は$CC$の元である。
一般に、$RR$の元は*スカラー*（scalar: 「大きさを変えるもの」の意）と呼ばれる。

我々が高校数学で学んだ$2$次元のベクトル空間$RR^2$を復習しよう。
ここではベクトルを太字で表し（たとえば、$arrow(a)$の代わりに$bold(a)$を用いる）、基本として列ベクトルを用いる。例えば、
$
  bold(a) = vec(a_0, a_1), bold(b) = vec(b_0, b_1) in RR^2
$
などという具合である。
ここで$RR^2$とは$2$次元実ベクトル全体の集合で、より一般に$n$次元実ベクトル全体の集合を$RR^n$、$n$次元複素ベクトル全体の集合を$CC^n$と表すこととする。

$
  RR^n eq.delta { vec(x_0, dots.v, x_(n - 1)) mid(|) x_i in RR },
  wide
  CC^n eq.delta { vec(z_0, dots.v, z_(n - 1)) mid(|) z_i in CC }
$

話を戻すと、$RR^2$には*スカラー倍*（定数倍ともいう）と*和*が定義されていた。

$
           lambda vec(x_0, x_1) & = vec(lambda x_0, lambda x_1) wide (lambda in RR) \
  vec(x_0, x_1) + vec(y_0, y_1) & = vec(x_0 + y_0, x_1 + y_1)
$

集合$RR^2$はスカラー倍および和について閉じている。
すなわち、$bold(a), bold(b) in bb(R)^2$ならば、いかなるスカラー$lambda in RR$についても$lambda bold(a) in RR^2$であり、$bold(a) + bold(b) in RR^2$である。

また$RR^n$についても同様にしてスカラー倍と和が定義される。

$
  lambda vec(x_0, dots.v, x_(n - 1)) & = vec(lambda x_0, dots.v, lambda x_(n - 1)) wide (lambda in RR) \
  vec(x_0, dots.v, x_(n - 1)) + vec(y_0, dots.v, y_(n - 1)) & = vec(x_0 + y_0, dots.v, x_(n - 1) + y_(n - 1))
$

集合$RR^n$も$RR^2$と同様に、スカラー倍と和について閉じている。

このように（大雑把に）スカラー倍と和について閉じた集合を*$RR$上の線形空間*という。

#axiom(name: [$RR$上の線形空間])[
  集合$V$において*スカラー倍*と*和*が定義されていて、かつ以下の条件を満たすとき、$V$を*$RR$上の線形空間*という。
  - 任意のスカラー$lambda in RR$と集合の元$bold(x) in V$に対して、$V$内にスカラー倍$lambda bold(x) in V$が定まり、次を満たす。
    + $forall lambda, mu in RR; forall bold(x) in V st (lambda mu) bold(x) = lambda (mu bold(x))$
    + $forall lambda in RR; forall bold(x), bold(y) in V st lambda(bold(x) + bold(y)) = lambda bold(x) + lambda bold(y)$
    + $forall lambda, mu in RR; forall bold(x) in V st (lambda + mu) bold(x) = lambda bold(x) + mu bold(x)$
    + $forall bold(x) in V st 1 bold(x) = bold(x)$
  - 集合の元$bold(x), bold(y) in V$に対して、$V$内に和$bold(x) + bold(y) in V$が定まり、次を満たす。
    + $forall bold(x), bold(y), bold(z) in V st (bold(x) + bold(y)) + bold(z) = bold(x) + (bold(y) + bold(z))$
    + $forall bold(x), bold(y) in V st bold(x) + bold(y) = bold(y) + bold(x)$
    + $exists! bold(0) in V, forall bold(x) in V st bold(x) + bold(0) = bold(x)$
    + $forall bold(x) in V, exists! (-bold(x)) st bold(x) + (-bold(x)) = bold(0)$
]

さて、随分仰々しく書いたものだが、$forall x$は「すべての$x$について」、$exists x$は「ある$x$が存在して」、$exists! x$は「ただ一つの$x$が存在して」を意味する。また、$"s.t."$は「such that」の略である。

$RR$上の線形空間はなにも$RR^n$に留まらない。例えば漸化式
#eqref(<zenkasiki>)[$
  a_(n + 3) = 4 a_(n + 2) - a_(n + 1) - a_n
$]
を満たす数列の集合$V$について考えよう。
${a_n}, {b_n} in V$について、スカラー倍と和を
$
  lambda {a_n} = {lambda a_n},
  wide
  {a_n} + {b_n} = {a_n + b_n}
$
のように定めれば、#[@zenkasiki]より
$
       lambda a_(n + 3) & = lambda(4 a_(n + 2) - a_(n + 1) - a_n) \
                        & = 4 (lambda a_(n + 2)) - (lambda a_(n + 1)) - (lambda a_n) \
  a_(n + 3) + b_(n + 3) & = (4 a_(n + 2) - a_(n + 1) - a_n) + (4 b_(n + 2) - b_(n + 1) - b_n) \
                        & = 4 (a_(n + 2) + b_(n + 2)) - (a_(n + 1) + b_(n + 1)) - (a_n + b_n)
$
であるから、$lambda {a_n} in V$かつ${a_n} + {b_n} in V$が成り立つ。よって$bold(0) = {0}_i$とすれば、$V$は$RR$上の線形空間であるといえる。

あるいは線形斉次常微分方程式
#eqref(<bibunhouteisiki>)[$
  (d^2 f)/(d x^2) - 4 (d f)/(d x) + 3 f = 0
$]
を満たす$RR$上の連続関数の集合$V$について考えよう。$f, g in V$について、スカラー倍と和を
$
  lambda f = lambda f(x),
  wide
  f + g = f(x) + g(x)
$
のように定めれば、#[@bibunhouteisiki]より
$
  lambda (d^2 f)/(d x^2) - 4 lambda (d f)/(d x) + 3 lambda f &= lambda((d^2 f)/(d x^2) - 4 (d f)/(d x) + 3 f) = 0 \
  d^2/(d x^2)(f + g) - 4 d/(d x)(f + g) + 3 (f + g) & = ((d^2 f)/(d x^2) - 4 (d f)/(d x) + 3 f) + ((d^2 g)/(d x^2) - 4 (d g)/(d x) + 3 g) = 0
$
であるから、$lambda f in V$かつ$f + g in V$が成り立つ。よって$bold(0) = 0$（恒等関数）とすれば、$V$は$RR$上の線形空間であるといえる。
このような空間はしばしば*解空間*と呼ばれる。

では、#[@zenkasiki]を満たし、かつ$a_0 = 0$である数列の集合$W$について考えよう。
${a_n}, {b_n} in W$について、スカラー倍と和を考えると
$
  lambda a_0 = lambda 0 = 0,
  wide
  a_0 + b_0 = 0 + 0 = 0
$
であるから、$lambda {a_n} in W$かつ${a_n} + {b_n} in W$が成り立つ。

このように、線形空間$V$の部分集合$W subset V$であって、スカラー倍および和について閉じたものを、$V$の*部分空間*という。
線形空間の部分空間もまた、線形空間である。

#definition(name: [部分空間], ref: <partial>)[
  線形空間$V$の部分集合$W subset V$であって、次を満たすものを$V$の*部分空間*という。
  + $lambda in RR, bold(a) in W ==> lambda bold(a) in W$
  + $bold(a), bold(b) in W ==> bold(a) + bold(b) in W$
]

例えば、#[@zenkasiki]を満たし$a_0 = 1$である数列の集合は、部分空間ではないことに注意せよ。
これは、$a_0 = 1$である数列は零元を含まないためである。試しに#theo-ref(<partial>)の条件1.に$lambda = 0$を代入してみよ。これにより次が得られる。

#corollary[
  線形空間$V$の零元$bold(0)$と部分空間$W$について、$bold(0) in W$。
]

また線形空間の閉包性について、とくに次が知られている。

#theorem(name: [線形空間の閉包性])[
  線形空間$V, W$について、
  + $V inter W$は$V$と$W$の部分空間であり、線形空間である。
  + $V union W$は必ずしも線形空間ではない。
]

#proof[
  $bold(x), bold(y) in V inter W$のとき、$V$と$W$がともに線形空間であることから、任意の$lambda in RR$について$lambda bold(x) in V$かつ$lambda bold(x) in W$であり、$lambda bold(x) in V inter W$。
  また、$bold(x) + bold(y) in V$かつ$bold(x) + bold(y) in W$であり、$bold(x) + bold(y) in V inter W$。
  ゆえに、$V inter W$は線形空間である。

  $V union W$が線形空間でない反例を示す。$RR^2$の部分空間$V = {vec(x, 0) mid(|) x in RR}$と$W = {vec(0, y) mid(|) y in RR}$を考えると、例えば$V union W$は$vec(1, 0) + vec(0, 1) = vec(1, 1)$を含まないため、線形空間でないことがわかる。
]

== 基底

再び$RR^2$に戻ろう。$bold(0)$でない任意の$2$次元実ベクトル$bold(a), bold(b) in RR^2$が平行でないとき（*一次独立*）、$RR^2$上の任意のベクトル$bold(x) in RR^2$は$bold(a)$と$bold(b)$の*一次結合*により一意に表すことができた。

さらに、$RR^2$上の任意のベクトルは
$
  bold(x) = lambda_0 vec(3, 2) + lambda_1 vec(-1, 4)
$
のように表すことができ、しかもその表し方$(lambda_0, lambda_1)$は一意である。

ここでこのときのベクトル$vec(3, 2)$と$vec(-1, 4)$を$RR^2$の*基底*という。
基底の定義は後述する。

線形空間において、$cal(A) = {bold(a)_0, dots, bold(a)_(n - 1)} subset V$について、一般に$lambda_i in RR$に関する*一次関係式*
$ sum_(i = 0)^(n - 1) lambda_i bold(a)_i = bold(0) $
が自明な解$lambda_0 = dots.c = lambda_(n - 1) = 0$を除く解をもたないとき、$cal(A)$は*一次独立*であるという。

逆に非自明な解$lambda'_0, dots, lambda'_(n - 1)$があれば、$lambda_k eq.not 0$を満たすものが少なくとも$1$つ存在し、両辺を$lambda_k$で割ることで$bold(a)_k$は
$
  bold(a)_k = - sum_(i = 0, i eq.not k)^(n - 1) lambda'_i / lambda'_k bold(a)_i
$
と他のベクトルの一次結合で表すことができる。このとき、$cal(A)$は*一次従属*であるという。

#definition(name: [一次独立])[
  線形空間$W$で$cal(A) = {bold(a)_0, dots, bold(a)_(n - 1)} subset W$をとる。実数$lambda_0, dots, lambda_(n - 1)$について
  $ sum_(i = 0)^(n - 1) lambda_i bold(a)_i = bold(0) ==> lambda_0 = dots.c = lambda_(n - 1) = 0 $
  がいえるとき、$cal(A)$は*一次独立*であるといい、さもなければ*一次従属*であるという。
]

#corollary[
  線形空間$W$の零元$bold(0)$を含む列は一次従属である。
]

#corollary[
  線形空間$W$の零でない単一の元による列${bold(a)}$は一次独立である。
]

ある$cal(A) = {bold(a)_0, dots, bold(a)_(n - 1)}$について、$bold(a)_k in cal(A)$が
$
  bold(a)_k = sum_(i = 0, i eq.not k)^(n - 1) lambda_i bold(a)_i
$
と表せるとき、$cal(A)$には非自明な一次関係式
$ sum_(i = 0, i eq.not k)^(n - 1) lambda_i bold(a)_i - bold(a)_k = bold(0) $
が存在する。よってそのような$cal(A)$は一次従属である。

これらの事実およびその対偶から、次のことが言える。

#theorem(ref: <dokuritsusei>)[
  $RR$上の線形空間$W$とその元集合$cal(A)$について
  + $cal(A)$は一次独立 $<==>$ $cal(A)$中の任意の元は他の元の一次結合で表せない
  + $cal(A)$は一次従属 $<==>$ $cal(A)$中の任意の元は他の元の一次結合で表せる
]

線形空間$V$の元$bold(a)_0, dots, bold(a)_(n - 1)$について
$ W = {sum_(i = 0)^(n - 1) lambda_i bold(a)_i mid(|) lambda_i in RR} $
を考えると、$bold(x), bold(y) in W$について$lambda bold(x) in W$で、かつ$bold(x) + bold(y) in W$が成り立つため、$W$は$V$の部分空間である。
特に$W$を*$bold(a)_0, dots, bold(a)_(n - 1)$が張る（生成する）部分空間*といい、$lr(chevron.l bold(a)_0, dots, bold(a)_(n - 1) chevron.r)$とかく。
また、$cal(A) = {bold(a)_0, dots, bold(a)_(n - 1)}$を$W$の*生成系*という。
なお、生成系は必ずしも一次独立である必要はないことに注意せよ。

たとえば前述の例を用いれば、次のように書ける。
$ RR^2 = lr(chevron.l vec(3, 2), vec(-1, 4) chevron.r) $

一般に、線形空間$W$について次の#theo-ref(<AgeB>)が成り立つ。証明は易しくないが、$RR^n$については後に導入する$rank$を用いて示すことができる。

#lemma(ref: <AgeB>)[
  線形空間$W$の生成系$cal(A)$と$W$の一次独立な部分集合$cal(B)$について
  $ |cal(A)| >= |cal(B)| $
]

線形空間$W$の生成系のうち、元の数が最小のものを*基底*と呼ぶこととする。
厳密な定義は次の通りである。基底の存在性を示すのは難しいが、$RR^n$については後述する。

#definition(name: [基底])[
  零元のみでない線形空間$W$の元$bold(a)_0, dots, bold(a)_(n - 1) in W$が次の条件をともに満たすとき、$cal(A) = {bold(a)_0, dots, bold(a)_(n - 1)}$は$W$の*基底*であるという。
  + $cal(A)$は$W$の生成系
  + $cal(A)$は一次独立
]

ここで前者は基底数の下限、後者は基底数の上限を定義している。すなわち、次がいえる。

#theorem(name: [基底の数])[
  零元のみでない線形空間$W$の基底の元数は、基底のとり方に依らない。
  すなわち、$cal(A)$と$cal(B)$がともに$W$の基底であるとき、$|cal(A)| = |cal(B)|$。
]

#proof[
  $cal(A)$と$cal(B)$がともに$W$の基底であるとき、$cal(A)$は$W$の生成系であるから、#theo-ref(<AgeB>)より$|cal(A)| >= |cal(B)|$。
  同様にして、$|cal(B)| >= |cal(A)|$も成り立つ。
  よって、$|cal(A)| = |cal(B)|$。
]

線形空間$W$について、その基底の元数は一位に定まり、これを$W$の*次元*と呼んで,
*$dim W$*と書き表すこととする。とくに${bold(0)}$について、*$dim {bold(0)} = 0$*を約束する。

#definition(name: [次元])[
  線形空間$W$の基底の元数を、線形空間$W$の*次元*といい、$dim W$と書く。
  すなわち、$dim{bold(0)} = 0$、あるいは${bold(0)}$でない$W$の任意の基底$cal(A)$について
  $ dim W = |cal(A)| $
]

#corollary(ref: <dirRRn>)[
  $ dim RR^n = n $
]

例えば${vec(1, dots.v, 0), dots.c, vec(0, dots.v, 1)}$は$RR^n$の基底で、とくに*標準基底*といって${bold(e)_0, dots, bold(e)_(n - 1)}$とかく。

また#theo-ref(<dirRRn>)と#theo-ref(<AgeB>)より、$RR^n$上の$n + 1$個以上のベクトルは一次従属である。

#proposition(name: [基底の存在])[
  $RR^n$の零元のみでない任意の部分空間$W eq.not {bold(0)}$には、必ず基底$cal(A)$が存在する。
]

#proof[
  背理法より示す。$W eq.not {bold(0)}$に基底が存在しないと仮定する。

  + $W eq.not {bold(0)}$であるから、零元でない元$bold(a)_0 in W$が選べる。
    いま、$cal(A)_1 = {bold(a)_0}$は一次独立であり、仮定より$lr(chevron.l bold(a)_0 chevron.r) subset.neq W$である。
  + $m >= 0$について$cal(A)_m$を選んだとする。$lr(chevron.l bold(a)_0, dots, bold(a)_m chevron.r) subset.neq W$より、$W$内に$cal(A)_m$の生成しない元$bold(a)_(m + 1) in W without lr(chevron.l bold(a)_0, dots, bold(a)_m chevron.r)$が選べて、#theo-ref(<dokuritsusei>)より$cal(A)_(m + 1) = cal(A)_m union {bold(a)_(m + 1)}$は一次独立である。
    また仮定より、$lr(chevron.l bold(a)_0, dots, bold(a)_(m + 1) chevron.r) subset.neq W$である。

  以上より、$W$には例えば$n + 1$個の一次独立な元の列$cal(A)_(n + 1)$が存在することとなる。
  しかし、#theo-ref(<dirRRn>)より$RR^n$上の$n + 1$個以上のベクトルは一次従属であり、矛盾。
]

一方で、上で述べた証明のように、$RR$上の任意の線形空間における一次独立な組から、その線形空間を張る基底を構成することができる。

#lemma(name: [基底への拡張], ref: <expand>)[
  $RR$上の${bold(0)}$でない線形空間$W$について、$W$上の一次独立な組$cal(A)$が与えられたとき、$W$の基底であって$cal(A)$の各元を含むものが存在する。
]

また、$RR$上の線形空間の次元について、とくに次のことが知られている。

#proposition[
  $RR$上の線形空間$V$と$W$について、$V subset W$であるとき
  + $dim V <= dim W$
  + $dim V = dim W <==> V = W$
]

前者は$V$の基底$cal(A)$をとると、$cal(A)$は$W$の一次独立な部分集合であるから、これを拡張することで$W$の基底$cal(B)$を構成することができ（#theo-ref(<expand>)）、このとき#theo-ref(<AgeB>)より$|cal(A)| <= dim W$であることから示される。
後者は背理法により示す。
いま$V subset.neq W$を仮定すると、$bold(a) in W without V$が存在する。
$bold(a)$は$cal(A)$の一次結合として書けないことから、$dim V + 1 <= dim W$であり、仮定に矛盾する。よって$V = W$であることがいえた。

== 座標

さて、我々が$RR$上の任意の線形空間を扱うにあたって、それぞれの元を表現する方法が必要となる。ここでは基底を用いた座標を導入する。

#definition(name: [座標])[
  零元のみでない線形空間$V$の基底$cal(A) = {bold(a)_0, dots, bold(a)_(n - 1)}$について、任意の元$bold(x) in V$が
  $ bold(x) = sum_(i = 0)^(n - 1) lambda_i bold(a)_i $
  と表せるとき、このような$bold(lambda) = vec(lambda_0, dots, lambda_(n - 1))$を*基底$cal(A)$に関する$bold(x)$の座標*という。
]

線形空間$W$の基底$cal(A) = {bold(a)_0, dots, bold(a)_(n - 1)}$に関する座標を考える。

+ $W$の元が異なる座標$bold(lambda) = vec(lambda_0, dots, lambda_(n - 1))$と$bold(mu) = vec(mu_0, dots, mu_(n - 1))$で表せると仮定しよう。このとき
  $
    (sum_(i = 0)^(n - 1) lambda_i bold(a)_i) - (sum_(i = 0)^(n - 1) mu_i bold(a)_i) = sum_(i = 0)^(n - 1) (lambda_i - mu_i) bold(a)_i = bold(0)
  $
  であり、$cal(A)$は一次独立であるから、すべての$i = 0, dots, n - 1$で$lambda_i = mu_i$となり、仮定に矛盾する。
  よって$W$の任意の元はある座標で一意に表せる。
+ $W$の元$bold(x)$と$bold(y)$が同じ座標$bold(lambda) = vec(lambda_0, dots, lambda_(n - 1))$で表せるならば、定義より$bold(x) = bold(y)$である。

これより次が結論付けられる。

#theorem[
  線形空間$W$の基底$cal(A)$に関する座標は、$W$の元を一意に表す。
]

例えば$RR^2$の基底$cal(A) = {vec(3, 2), vec(-1, 4)}$に関する$vec(5, 8)$の座標を$vec(p, q)$とおけば
$ vec(5, 8) = p vec(3, 2) + q vec(-1, 4) $
であり、これを解くことで$vec(p, q) = vec(2, 1)$を得る。

また、$2$次多項式の集合$V$の基底$cal(A) = {1, x - 1, (x - 1)^2}$に関する$f(x) = x^2 + 1$の座標は、$f(x) = x^2 + 1 = 2 + 2(x - 1) + (x - 1)^2$から$vec(2, 2, 1)$である。

これ以降、特に断りがなければ、線形空間の元をその基底に関する座標で表すこととする。これにより、一般の線形空間を考えることなく、その元を$RR^n$のベクトルとして一元的に扱うことができるようになる。

== 線形写像

$bold(x) in RR^n$に対して、何か法則や公式などで$f(bold(x)) in RR^m$が対応するとき、$f: RR^n --> RR^m$または$RR^n -->^f RR^m$などと書き、$f$を*$RR^n$から$RR^m$への写像*という。

$RR$から$RR$への写像$f$を考えよう。これについて、以下の二条件は同値だろうか。
$
  phi(f) & : forall lambda in RR, forall x in RR st f(lambda x) = lambda f(x) \
  psi(f) & : exists a in RR, forall x in RR st f(x) = a x
$

- $phi(f) ==> psi(f)$について考える。写像$f$について$f(1)$が存在して、$phi(f)$より$ f(x) = f(1 dot x) = f(1) f(x) $とかける。よって$a = f(1)$とすることで$psi(f)$は満たされる。

- $psi(f) ==> phi(f)$について考える。$psi(f)$より$ f(lambda x) = a(lambda x) = lambda (a x) = lambda f(x) $とかけるため、$phi(f)$は満たされる。

これより、$phi(f) <==> psi(f)$が確かめられた。

では、$RR^2$から$RR^2$への写像$f$について、以下の二条件は同値だろうか。
$
  phi(f) & : forall lambda in RR, forall bold(x) in RR^2 st f(lambda bold(x)) = lambda f(bold(x)) \
  psi(f) & : exists a, c in RR^2; forall bold(x) = vec(x_0, x_1) in RR^2 st f(bold(x)) = vec(a x_0, c x_1)
$

これらは同値ではない。たとえば$f(vec(x, y)) = vec(y, x)$などはその反例である。

これは正比例の拡張の方法が適切でなかったことを意味する。

代わりに以下の$phi_1(f) and phi_2(f)$と$psi(f)$は同値である。
$
  phi_1(f) & : forall lambda in RR, forall bold(x) in RR^2 st f(lambda bold(x)) = lambda f(bold(x)) \
  phi_2(f) & : forall bold(x), bold(y) in RR^2 st f(bold(x) + bold(y)) = f(bold(x)) + f(bold(y)) \
  psi(f) & : exists a, b, c, d in RR; forall bold(x) = vec(x_0, x_1) in RR^2 st f(bold(x)) = vec(a x_0 + b x_1, c x_0 + d x_1)
$

#proof[
  まず、$phi_1(f) and phi_2(f) ==> psi(f)$を示す。$phi_1(f)$と$phi_2(f)$より
  $
    f(bold(x)) & = f(x_0 bold(e)_0 + x_1 bold(e)_1) = f(x_0 bold(e)_0) + f(x_1 bold(e)_1) \
               & = x_0 f(bold(e)_0) + x_1 f(bold(e)_1)
  $
  を得る。よって$vec(a, c) = f(bold(e)_0)$、$vec(b, d) = f(bold(e)_1)$とすることで、$psi(f)$が成り立つ。

  次に、$psi(f) ==> phi_1(f)$を示す。$psi(f)$より
  $
    f(lambda bold(x)) = f(vec(lambda x_0, lambda x_1)) = vec(a lambda x_0 + b lambda x_1, c lambda x_0 + d lambda x_1) = lambda vec(a x_0 + b x_1, c x_0 + d x_1) = lambda f(bold(x))
  $
  だから、成り立つ。

  さらに、$psi(f) ==> phi_2(f)$を示す。$psi(f)$より
  $
    f(bold(x) + bold(y)) & = f(vec(x_0 + y_0, x_1 + y_1)) = vec(a (x_0 + y_0) + b (x_1 + y_1), c (x_0 + y_0) + d (x_1 + y_1)) \
    & = vec(a x_0 + b x_1, c x_0 + d x_1) + vec(a y_0 + b y_1, c y_0 + d y_1) = f(bold(x)) + f(bold(y))
  $
  だから、成り立つ。
]

このように、*斉次性*$phi_1(f)$と*加法性*$phi_2(f)$をともに満たす写像$f$を、*線形写像*という。

// #pagebreak()

#definition(name: "線形写像")[
  線形空間$V$から線形空間$W$への写像$f: V --> W$が*線形写像*であるとは、写像$f$が
  / 斉次性: $forall lambda in RR, forall bold(x) in V st f(lambda bold(x)) = lambda f(bold(x))$
  / 加法性: $forall bold(x), bold(y) in V st f(bold(x) + bold(y)) = f(bold(x)) + f(bold(y))$
  をともに満たすことをいう。両者を合わせて*線形性*という。
]

線形写像は、正比例の一般化ともいえる。
とくに線形写像のうち$V$から$V$への写像を、$V$の*線形変換*という。
たとえば$id^n: RR^n --> RR^n, id^n (bold(x)) = bold(x)$はとくに恒等変換という。

#corollary[
  線形写像$f: V --> W$は次を満たす。
  $ f(bold(0)) = bold(0), wide f(-bold(x)) = -f(bold(x)) $
]

例えば、$f: RR^2 --> RR^2, f(vec(x, y)) = vec(x + 1, y - 1)$は$f(bold(0)) = bold(0)$を満たさないため、線形写像ではない。あるいは$f: RR^2 --> RR^2, f(vec(x, y)) = vec(x^2, y^2)$も$f(-bold(x)) = -f(bold(x))$を満たさず、線形写像ではない。

== 行列

一般の$RR^n$から$RR^m$への線形写像$f$を考える。$RR^n$の標準基底$bold(e)_0, dots, bold(e)_(n - 1)$について
$
  bold(x) = sum_(i = 0)^(n - 1) x_i bold(e)_i wide x_i in RR
$
であると考えると、$f(bold(x))$はその線形性から
$
  f(bold(x)) = sum_(i = 0)^(n - 1) f(x_i bold(e)_i) = sum_(i = 0)^(n - 1) x_i f(bold(e)_i)
$
と書ける。
ここで$f(bold(e)_i) in RR^m thick (0 <= i < n)$は$f$に依存する列ベクトルの列であり、とくに線形写像$f$を特徴づけるものである。


言い換えれば、$RR^n$から$RR^m$への線形写像$f$を再現するには、*基底$cal(A)$に対する線形写像$f$の結果のみを記憶するだけでよい*。
この列を
$
  A = mat(f(bold(e)_0), dots.c, f(bold(e)_(n - 1)))
$
とおくと、$A$と$f$は$1:1$に対応する。
このような$A$は陽に列表記せず、たとえば前述した$id^2: RR^2 --> RR^2, f(bold(x)) = bold(x)$と対応する$I_2$を考えると
$
  I_2 = mat(1, 0; 0, 1)
$
などのように表記される。
この$A$や$I_2$などを*行列*と呼ぶ。
とくに$RR^n$から$RR^m$への線形写像を定める行列を*$m times n$実行列*といい、$RR^n$の線形変換を定める行列を*$n$次正方実行列*という。

$RR$上の$m times n$行列全体の集合を$RR^(m times n)$などと書き表すことがある。
例えば$I_2 in RR^(2 times 2)$。

#definition(name: [行列])[
  $RR$上の*$m times n$実行列*とは、ある線形写像$f: RR^n --> RR^m$を定めるベクトル列で、
  $ A = mat(f(bold(e)_0), dots.c, f(bold(e)_(n - 1))) $
  である。とくにその線形写像を$f(bold(x)) = A bold(x)$などとかく。
]

あるベクトル$bold(x) in RR^n$が$bold(x) = vec(x_0, dots.v, x_(n - 1))$と表せるとき、$x_i$を$bold(x)$の$i$成分という。

いま、$bold(x) in RR^n$について$bold(y) in RR^m$があって、$bold(y) = A bold(x)$を満たすとする。
このとき$bold(y)$の$i$成分$y_i$は、$A$の$j thick (0 <= j < n)$番目の列ベクトルの$i$成分$a_(i, j)$（$A$の$(i, j)$成分という）を用いて
$ y_i = sum_(j = 0)^(n - 1) a_(i, j) x_j $
とかけることは、$f(bold(e)_k)$の$i$成分のみを見ることより明らかである。

よって、$RR^m$の標準基底を$bold(tilde(e))_i$とすれば、$display(bold(y) = sum_(i = 0)^(m - 1) y_i bold(tilde(e))_i)$より、次が言える。ただし、$A$の$(i, j)$成分が既知であるとき、行列$A$を$mat(display(a_(i, j)))_(i, j)$と書くこととする。

#theorem[
  行列$A = mat(display(a_(i, j)))_(i, j)$が$f: RR^n --> RR^m$を定めるとき、$bold(y) = A bold(x)$は次で書ける。
  $ bold(y) = sum_(i = 0)^(m - 1) bold(tilde(e))_i sum_(j = 0)^(n - 1) a_(i, j) x_j $
]

== 行列の計算

=== 積

#definition(name: [合成写像])[
  写像$f$と$g$があって
  $V_1 -->^f V_2 -->^g V_3$
  を満たすとき、$f$と$g$の*合成写像 $g compose f$*を
  $ (g compose f)(bold(x)) eq.delta g(f(bold(x))) $と定義する。
]

いま、$m times n$実行列$A$の定める線形写像$f$と$l times m$実行列$B$の定める線形写像$g$があって
$ RR^n -->^f RR^m -->^g RR^l $
を満たすとする。このとき合成写像$g compose f$は$bold(x), bold(y) in RR^n$および$lambda in RR$について
$
  (g compose f)(lambda bold(x)) &= g(f(lambda bold(x))) = g(lambda f(bold(x))) = lambda g(f(bold(x))) = lambda (g compose f)(bold(x)) \
  (g compose f)(bold(x) + bold(y)) &= g(f(bold(x) + bold(y))) = g(f(bold(x)) + f(bold(y))) \
  &= g(f(bold(x))) + g(f(bold(y))) = (g compose f)(bold(x)) + (g compose f)(bold(y))
$
が成り立つから、$g compose f$もまた線形写像である。よって$g compose f$に対応する行列$C$が存在して
$ C bold(x) = B(A bold(x)) $
を満たす。そこで$bold(y) = A bold(x)$とおくと
$ y_k = sum_(j = 0)^(n - 1) a_(k, j) x_j $
とかけて、さらに$bold(z) = B bold(y)$とおくと
#eqref(<zBy>)[$
  z_i = sum_(k = 0)^(m - 1) b_(i, k) y_k = sum_(k = 0)^(m - 1) sum_(j = 0)^(n - 1) (b_(i, k) a_(k, j)) x_j
$]
とかける。$bold(z) = C bold(x)$であることを思い出すと
#eqref(<zCx>)[$
  z_i = sum_(j = 0)^(n - 1) c_(i, j) x_j
$]
であり、#[@zBy]と#[@zCx]を比較することで
$ c_(i, j) = sum_(k = 0)^(m - 1) b_(i, k) a_(k, j) $
を得る。ここで*$C = B A$*と表し、これを*行列$B$と$A$の積*という。
$ (B A) bold(x) = B (A bold(x)) $

一般に、行列の積は*非可換*である（すなわち、$A B = B A$とは限らない）。

#theorem(name: [合成写像と積行列])[
  $m times n$実行列$A$と$l times m$実行列$B$の定める線形写像$f$と$g$について、その合成写像$g compose f$は線形写像であり、*積$B A$*は$g compose f$を定める。
]

#theorem(name: [行列の積])[
  $l times underline(m)$実行列$B = mat(display(b_(i, j)))_(i, j)$と$underline(m) times n$実行列$A = mat(display(a_(i, j)))_(i, j)$について積$B A$が定まり、
  $ B A = mat(display(sum_(k = 0)^(m - 1) b_(i, k) a_(k, j)))_(i, j) $
  とかける。
]

=== 逆行列

#definition(name: [逆変換])[
  空間$V$上の*変換*$f: V --> V$があって、任意の$bold(y) in V$について$f(bold(x)) = bold(y)$を満たす$bold(x) in V$が唯一に定まるとき、*逆変換*$f^(-1): V --> V$が定まって、$bold(x) = f^(-1)(bold(y))$とする。
]

いま、$n$次正方行列$A$とこれの定める$RR^n$上の線形変換$f: RR^n --> RR^n$があって、これが$RR^n$上の*逆変換*$f^(-1): RR^n --> RR^n$を持つとする。
このとき逆変換$f^(-1)$は
$
  f^(-1)(lambda bold(x)) = lambda f^(-1)(bold(x)),
  wide
  f^(-1)(bold(x) + bold(y)) = f^(-1)(bold(x)) + f^(-1)(bold(y))
$
を満たすから、$f^(-1)$もまた線形写像である。このとき
$ RR^n -->^f RR^n -->^(f^(-1)) RR^n $
を考えると、$f^(-1)$に対応する行列$B$は、任意の$bold(x) in RR^n$について次のように表せる。
#eqref(<BAxisx>)[$ B A bold(x) = bold(x) $]

さて、突然だが恒等変換$id^n: RR^n --> RR^n, id^n (bold(x)) = bold(x)$を考える。これを定める$n times n$行列$I_n$（単に$I$とも書く）は*単位行列*と呼ばれ、$RR^n$の標準基底${bold(e)_0, dots.c, bold(e)_(n - 1)}$を用いて
$
  I_n = mat(bold(e)_0, dots.c, bold(e)_(n - 1)) = mat(1, , bold(0); , dots.down, ; bold(0), , 1)
$
のように、対角線が上の要素が$1$、それ以外の要素が$0$の行列として書ける。

これによれば#[@BAxisx]は次のように書ける。
$ B A bold(x) = I_n bold(x) quad <==> quad B A = I_n $

このような関係式を満たすような行列$B$を$A$の*逆行列*といい、*$B = A^(-1)$*と書く。

#definition(name: [正則行列と逆行列])[
  $n$次正方行列$A$について、次を満たすような行列$A^(-1)$を$A$の*逆行列*という。
  $ A^(-1) A = I_n $

  ただし、$A^(-1)$が存在するような行列$A$は*正則である*といい、*正則行列*という。
]

補足。単位行列$I$は*クロネッカーのデルタ*
$ delta_(i, j) = cases(1 quad "if" i = j, 0 quad "othewise") $
を用いて$I = mat(display(delta_(i, j)))_(i, j)$とかける。

=== スカラー倍

$m times n$実行列$A$が定める線形写像$f: RR^n --> RR^m$、$m$次正方実行列$Lambda_m = mat(display(lambda delta_(i, j)))_(i, j)$の定める線形写像$lambda_m: RR^m --> RR^m, f(bold(x)) = lambda bold(x)$について、合成写像$lambda_m compose f$もまた線形写像であるから、これを定める$m times n$実行列を$L_1 = Lambda_m A$とおくと、
$
  c_(i, j) = sum_(k = 0)^(m - 1) (lambda delta_(i, k)) a_(k, j) = lambda a_(i, j)
$
である。また、$n$次正方実行列$Lambda_n = mat(display(lambda delta_(i, j)))_(i, j)$の定める線形写像$lambda_n: RR^n --> RR^n, lambda_n(bold(x)) = lambda bold(x)$について、合成写像$f compose lambda_n$もまた線形写像であるから、これを定める$m times n$実行列を$L_2 = A Lambda_n$とおくと、
$
  c_(i, j) = sum_(k = 0)^(n - 1) a_(i, k) (lambda delta_(k, j)) = lambda a_(i, j)
$
となる。つまり、$Lambda_m A = A Lambda_n = mat(display(lambda a_(i, j)))_(i, j)$であり、これを単に$lambda A = A lambda$と書くこととする。

#theorem[
  $m times n$実行列$A$と$lambda in RR$について、*スカラー倍*$lambda A$は次のように書ける。
  $ lambda A = mat(display(lambda a_(i, j)))_(i, j) $
]

また、これを用いると先程の$Lambda_m$および$Lambda_n$は
$ Lambda_m = lambda I_m, wide Lambda_n = lambda I_n $
とかける。

=== 和

$m times n$行列$A$、$B$が定める線形写像$f: RR^n --> RR^m$、$g: RR^n --> RR^m$について、その和$f + g$を考える。
ただし、$(f + g)(bold(x)) = f(bold(x)) + g(bold(x))$とする。

$
      lambda(f + g)(bold(x)) & = lambda(f(bold(x)) + g(bold(x))) = lambda f(bold(x)) + lambda g(bold(x)) \
                             & = f(lambda bold(x)) + g(lambda bold(x)) = (f + g)(lambda bold(x)) \
  (f + g)(bold(x) + bold(y)) & = f(bold(x) + bold(y)) + g(bold(x) + bold(y)) \
                             & = f(bold(x)) + f(bold(y)) + g(bold(x)) + g(bold(y)) \
                             & = (f + g)(bold(x)) + (f + g)(bold(y))
$

以上より、$f + g$もまた線形写像である。

#theorem[
  線形写像$f$と$g$について、その和$f + g$もまた線形写像である。
]

$f + g$を定める行列を$C$とおくと、$bold(y) = (f + g)(bold(x))$について
$
  y_i = sum_(j = 0)^(n - 1) a_(i, j) x_j + sum_(j = 0)^(n - 1) b_(i, j) x_j = sum_(j = 0)^(n - 1) (a_(i, j) + b_(i, j)) x_j = sum_(j = 0)^(n - 1) c_(i, j) x_j
$
となるから、$mat(display(c_(i, j)))_(i, j) = mat(display(a_(i, j) + b_(i, j)))_(i, j)$である。これを単に$A + B$と書くこととする。

#theorem[
  $m times n$実行列$A$、$B$について、*和*$A + B$は次のように書ける。
  $ A + B = mat(display(a_(i, j) + b_(i, j)))_(i, j) $
]
