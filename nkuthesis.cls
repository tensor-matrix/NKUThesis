% -*- coding: utf-8 -*-

\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{nkuthesis}[2023/4/25]
\LoadClass[12pt,openany]{ctexbook}

\newif\if@NKT@doublemajor
\DeclareOption{doublemajor}{\@NKT@doublemajortrue}
\newif\if@NKT@multiuline
\DeclareOption{multiuline}{\@NKT@multiulinetrue}
\ProcessOptions\relax

\newcommand\jiacu[1][.2]{\special{pdf: literal direct q #1 w 2 Tr}\aftergroup\bujiacu}
\def\bujiacu{\special{pdf: literal 0 Tr}}

\RequirePackage[nocheck]{fancyhdr}
\RequirePackage{geometry}
\geometry{a4paper,top=25.4mm,bottom=25.4mm,left=31.7mm,right=31.7mm}

%  字体设定

\setCJKmainfont[BoldFont={SimHei},ItalicFont={[simkai.ttf]}]{SimSun}
%\setCJKmonofont{[simfang.ttf]}
%\setmainfont{Times New Roman}
\punctstyle{quanjiao}

%  目录设定

\def\contentsname{目\hskip 1em 录}

\RequirePackage[titles]{tocloft}
\renewcommand{\cftdot}{$\cdot$}
\renewcommand{\cftdotsep}{1.5}
\setlength{\cftbeforechapskip}{10pt}

\renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}}
\renewcommand{\cftchapdotsep}{\cftdotsep}
\renewcommand{\cftchapfont}{\zihao{-3}}
\renewcommand{\cftsecfont}{\zihao{4}}
\renewcommand{\cftsubsecfont}{\zihao{-4}}
\setlength\cftbeforechapskip{.5em}
\setlength\cftbeforesecskip{.2em}
\setlength\cftbeforesubsecskip{0em}
\cftsetindents{section}{2.5em}{1em}
\cftsetindents{subsection}{5em}{1em}

\renewcommand{\numberline}[1]{%
	\settowidth\@tempdimb{#1\hspace{0.5em}}%
	\ifdim\@tempdima<\@tempdimb%
	\@tempdima=\@tempdimb%
	\fi%
	\hb@xt@\@tempdima{\@cftbsnum #1\@cftasnum\hfil}\@cftasnumb}

\let\oldtableofcontents\tableofcontents
\renewcommand\tableofcontents{%
    \oldtableofcontents
    \clearpage
	\setcounter{page}{1}
	\pagenumbering{arabic}}

\def\theequation{\arabic{chapter}.\arabic{equation}}
\@addtoreset{equation}{chapter}
\let\oldappendix\appendix
\renewcommand\appendix{\oldappendix\setcounter{equation}{0}}

%  页面样式设定

\pagestyle{fancy}
\fancyhf{}
\chead{\zihao{5}\leftmark}
\cfoot{\thepage}

\RequirePackage[bookmarksnumbered]{hyperref}
\hypersetup{colorlinks=true,
	pdfborder=0 0 1,
	citecolor=black,
	linkcolor=black}

\ctexset{%
    secnumdepth=3,
    part={%
        format=\centering\huge\bfseries},
    chapter={%
        format=\centering\zihao{-3}\rmfamily\bfseries\jiacu,
        pagestyle=fancy,
        beforeskip=10pt,
        afterskip=40pt},
    section={%
        format=\centering\bfseries\jiacu\zihao{4},
        name={第,节},
        number=\chinese{section},
        beforeskip=17.5pt,
        afterskip=12.5pt},
    subsection={%
        format=\bfseries\zihao{-4},
        beforeskip=5pt,
        afterskip=5pt},
    subsubsection={%
        format=\bfseries\zihao{-4},
        name={(,)},
        number=\arabic{subsubsection},
        beforeskip=5pt,
        afterskip=5pt}
}


\linespread{1.5}

%  图表标题及编号格式设定

\def\belowcaptionskip@table{6pt}
\def\belowcaptionskip@figure{12pt}

\def\thefigure{\arabic{chapter}.\arabic{figure}}
\def\thetable{\arabic{chapter}.\arabic{table}}
\def\tablecaption#1{%
  \refstepcounter{table}%
  {\zihao{5}表\nobreakspace\thetable\hskip 1em #1}
  \nopagebreak
  \vskip\belowcaptionskip@table
  \nopagebreak}

\def\figurecaption#1{%
  \refstepcounter{figure}%
  \nopagebreak
  \vskip 0pt
  \nopagebreak
  {\zihao{5}图\nobreakspace\thefigure\hskip 1em #1}
  \vskip\belowcaptionskip@figure}

\RequirePackage{pifont}
\renewcommand\thefootnote{\ding{\numexpr171+\@arabic\c@footnote\relax}}
\RequirePackage{xpatch}
\xpatchcmd\@makefntext
  {{\hss\@makefnmark}}
  {{\hss\@makefnmark@nosuperscript}\space}
  {}{\fail}
\def\@makefnmark@nosuperscript{\lower .05ex\hbox{\normalfont\@thefnmark}}

%  论文基本信息设定

\RequirePackage{keyval}

\def\NKT@definekey#1#2{%
  \define@key{NKT}{#1}[]{%
    \expandafter\def\csname NKT@key@#2\endcsname{##1}}}

\NKT@definekey{中文题目}      {titlecn}
\NKT@definekey{外文题目}      {titleen}
\NKT@definekey{学号}          {id}
\NKT@definekey{姓名}          {name}
\NKT@definekey{年级}          {grade}
\NKT@definekey{专业}          {major}
\NKT@definekey{系别}          {department}
\NKT@definekey{学院}          {college}
\NKT@definekey{双修专业}      {dmajor}
\NKT@definekey{双修院系}      {dcollege}
\NKT@definekey{指导教师}      {teacher}
\NKT@definekey{完成日期}      {date}

\def\NKT@keyvalue#1{%
    \edef\NKT@temp{\csname NKT@key@#1\endcsname}%
    \scantokens\expandafter{\NKT@temp}}

\def\NKTsetup#1{
    \bgroup
        \setkeys{NKT}{#1}%
        \pagestyle{empty}
        \@twosidefalse
        \newgeometry{left=0mm,right=0mm,top=2mm}
        \NKTtitlepage
        \restoregeometry
        \NKT@declaration
    \egroup
    \clearpage
    \setcounter{page}{1}
    \pagenumbering{Roman}
}

\long\def\NKTtitlepage{%
    \clearpage
    \bgroup
    \parindent 0em
    \thispagestyle{empty}
    \,
    \vskip 3cm
    \begin{center}
        {\ziju{2}\fontsize{44}{0}\jiacu[1] 南开大学}
        \vskip 15mm
        {\ziju{.2}\fontsize{24}{0}本科生毕业论文（设计）\\[.3em]
        \if@NKT@doublemajor
            （双学位专用）
        \fi}
        \vskip 12mm
        \large
        \def\disheight{.4em}
        \def\ddisheight{.8em}
        \vbox to 15mm{%
            \NKT@tp@item{中文题目}{titlecn}\\[\ddisheight]
            \NKT@tp@item{外文题目}{titleen}
        \vss}
    \vskip 5cm
    \NKT@tpp@item{学号}{id}\\[\disheight]
    \NKT@tpp@item{姓名}{name}\\[\disheight]
    \NKT@tpp@item{年级}{grade}\\[\disheight]
    \NKT@tpp@item{专业}{major}\\[\disheight]
    \NKT@tpp@item{系别}{department}\\[\disheight]
    \NKT@tpp@item{学院}{college}\\[\disheight]
    \if@NKT@doublemajor
        \NKT@tppp@item{双修专业}{dmajor}\\[\disheight]
        \NKT@tppp@item{双修院系}{dcollege}\\[\disheight]
    \fi
    \NKT@tppp@item{指导教师}{teacher}\\[\disheight]
    \NKT@tppp@item{完成日期}{date}
    \end{center}
  \egroup
}

\RequirePackage{setspace}

\if@NKT@multiuline
    \RequirePackage{formular}
    \setFRMbreakstyle
    \setFRMfontsize{14}
    \setFRMmargin{0pt}
    \setFRMbaselineskip{24pt}
    \setFRMrulesep{4pt}
    \setFRMfontfamily{Times New Roman}
    \newFRMenvironment{twounder}{}{1}
    \def\NKT@tp@item#1#2{%
        \parbox{5em}{ \par#1 ：}%
        \hskip 0.5em%
        \parbox[t][][t]{123mm}{\vskip-21.4mm\centering\singlespacing\begin{twounder}\NKT@keyvalue{#2}\end{twounder}}}
\else
    \def\NKT@tp@item#1#2{%
        \parbox{5em}{ \par#1 ：}%
        \hskip 0.5em%
        \underline{\parbox[b]{123mm}{\vskip-8mm\centering\singlespacing\NKT@keyvalue{#2}}}}
\fi

\def\NKT@tpp@item#1#2{%
    {\ziju{2}#1}：%
    \hskip 0.5em%
    \underline{\hbox to 45mm{\hfil\NKT@keyvalue{#2}\hfil}}}

\def\NKT@tppp@item#1#2{%
    #1 ：%
    \hskip 0.5em%
    \underline{\hbox to 45mm{\hfil\NKT@keyvalue{#2}\hfil}}}


\def\NKT@declaration{%
    \clearpage
    \thispagestyle{empty}
    \,
    \vskip 1cm
    \begin{center}
        {\ziju{.06}\zihao{2}\bfseries\jiacu 关于南开大学本科生毕业论文（设计）\\[.2em]
        的声明}
    \end{center}
    \vskip 1cm
    \zihao{-4}

    本人郑重声明：所呈交的学位论文，是本人在指导教师指导下，进行研究工作所取得的成果。除文中已经注明引用的内容外，本学位论文的研究成果不包含任何他人创作的、已公开发表或没有公开发表的作品内容。对本论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确方式标明。本学位论文原创性声明的法律责任由本人承担。
    \vskip 1.5em
    \begin{flushright}
        学位论文作者签名：\phantom{年\qquad 月\qquad 日}\\
        年\qquad 月\qquad 日
    \end{flushright}
    \vskip 3cm

    本人声明：该学位论文是本人指导学生完成的研究成果，已经审阅过论文的全部内容，并能够保证题目、关键词、摘要部分中英文内容的一致性和准确性。
    \vskip 1.5em
    \begin{flushright}
        学位论文指导教师签名：\phantom{年\qquad 月\qquad 日}\\
        年\qquad 月\qquad 日
    \end{flushright}
    }

\def\abstractcn{
    \clearpage
    \chapter*{\zihao{4}\rmfamily\bfseries\jiacu 摘\hskip 1em 要}
    \addcontentsline{toc}{chapter}{摘要}
    \markboth{摘要}{摘要} 
    \vspace*{-20pt}
    \zihao{-4}}
\let\endabstractcn\relax

\def\abstract{
    \clearpage
    \chapter*{\zihao{4}\usefont{OT1}{phv}{bx}{n}Abstract}
    \addcontentsline{toc}{chapter}{Abstract}
    \markboth{Abstract}{Abstract}
    \vspace*{-20pt}
    \zihao{-4}}
\let\endabstract\relax

\long\def\keywordscn{\par{\noindent\rmfamily\jiacu\zihao{-4} 关键词：}}
\let\endkeywordscn\relax

\long\def\keywords{\par{\noindent\rmfamily\jiacu[.5]\zihao{-4} Key Words: }}
\let\endkeywords\relax

\def\maketoc#1{%
\addcontentsline{toc}{chapter}{#1}
\chead{\zihao{5}#1}}

\def\bibstyle{\ctexset{chapter/format=\zihao{3}\rmfamily\bfseries\jiacu}
\linespread{1.0}
\zihao{5}}

\newtheorem{Theorem}{\hskip 2em 定理}[chapter]
\newtheorem{Lemma}[Theorem]{\hskip 2em 引理}
\newtheorem{Corollary}[Theorem]{\hskip 2em 推论}
\newtheorem{Proposition}[Theorem]{\hskip 2em 命题}
\newtheorem{Definition}[Theorem]{\hskip 2em 定义}
\newtheorem{Example}[Theorem]{\hskip 2em 例}
\newtheorem{proof}[Theorem]{\hskip 2em 证明}

\def\Romannum#1{\uppercase\expandafter{\romannumeral#1}}
\def\romannum#1{\romannumeral#1}

\DeclareSymbolFont{epsilon}{OML}{ntxmi}{m}{it}
\DeclareMathSymbol{\epsilon}{\mathord}{epsilon}{"0F}
