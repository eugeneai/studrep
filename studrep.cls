%% studrep.cls
%% Copyright 2019--2022 Irkutsk State University (math.isu.ru)
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Evgeny A. Cherkashin.
% The code was originally based on 'ceurart' code.
%

\def\RCSfile{studrep}%
\def\RCSversion{0.1.0}%
\def\RCSdate{2022/05/16}%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\RCSfile}[\RCSdate, \RCSversion: Typesetting students' reports]

\RequirePackage{expl3,xparse}
\@ifundefined{regex_match:nnTF}{\RequirePackage{l3regex}}{}

% \ExplSyntaxOn

\LoadClass{scrreprt}

\RequirePackage{iftex}
\RequirePackage{etoolbox}
\ifPDFTeX\relax
 \RequirePackage[utf8]{inputenc}
 \RequirePackage{times}
\else
 \RequirePackage{luatextra}
\fi
\RequirePackage[english,russian]{babel}
\RequirePackage{amssymb,amsmath,amsfonts}
\@ifpackageloaded{amsthm}{}{
\RequirePackage{ntheorem}
}
\RequirePackage{geometry}
\RequirePackage{longtable}
\RequirePackage{fancyhdr}
\RequirePackage{indentfirst}
\RequirePackage{caption}
\RequirePackage{pageslts}
\RequirePackage{tocloft}
\RequirePackage{calc}
\RequirePackage{secdot}
\RequirePackage{cmap}
\RequirePackage{appendix}
\RequirePackage[final]{hyperref}
\RequirePackage[sort&compress]{natbib} % Adjusting \cite's
\ifPDFTeX\relax
\else
\RequirePackage{unicode-math}
\fi
\RequirePackage[perpage,marginal,hang]{footmisc}

\RequirePackage[protrusion=false,expansion=false]{microtype}

\RequirePackage{color}
\definecolor{mygreen}{rgb}{0,0.6,0}
\ifPDFTeX\relax
\DeclareMathAlphabet{\mathbfit}{OML}{cmm}{b}{it} % stub
\def\LaTeXsys{\LaTeX2e}
\else
\defaultfontfeatures{Ligatures={TeX,Required},Scale=MatchLowercase}
\def\LaTeXsys{\LuaLaTeX}
\fi
\def\su@colonsize{\small}
\newcommand\su@scale{1.0}
\newcommand\su@chapter@font@size{\LARGE} % For Chapter sizes
\def\su@title@indent{\z@}
\def\su@chapter@font{\bfseries}
\def\sutitlefont{\su@chapter@font}
\def\su@sec@title@font{\normalfont}
\def\su@par@title@font{\normalfont}
\def\su@sec@size{\Large}
\def\su@subsec@size{\large}
\def\su@subsubsec@size{\normalsize}
\newcommand\sutypeface{Computer Modern}
\newcommand\sufontfamily{\sutypeface}
\let\su@sec@indent\z@

\setcitestyle{numbers,square}
\def\isu@defgeom{\geometry{}}

\let\chapter@su@name=\chaptername

%-------------------- Option declarations ----------------------------

\def\sbk@fontpath{subook/}
\let\su@trans@func\relax

\def\@makeschapterhead#1{%
  %\vspace*{30\p@}%
  {\parindent \z@ \raggedright
    \interlinepenalty\@M
    \hyphenpenalty\@M
    {\su@chapter@font@size \su@chapter@font \su@trans@func #1\par\nobreak}
    \vskip 15\p@ %% Here
  }}


\geometry{paper=a4paper, includehead, left=2.5cm, right=2.5cm, top=1.7cm, bottom=2.5cm}
\let\headwidth=\textwidth

\DeclareOption{microtyping}{
% activate={true,nocompatibility} - activate protrusion and expansion
% final - enable microtype; use "draft" to disable
% tracking=true, kerning=true, spacing=true - activate these techniques
% factor=1100 - add 10% to the protrusion amount (default is 1000)
% stretch=10, shrink=10 - reduce stretchability/shrinkability (default is 20/20)
\SetProtrusion
    [name=std]
    {
      encoding={utf8},
      family=*}
    {
    « = {300,     },
    » = {    , 300},
    „ = {300,     },
    “ = {    , 300},
    ( = {300,     },
    ) = {    , 300},
    ! = {    , 300},
    ? = {    , 300},
    : = {    , 300},
    ; = {    , 300},
    . = {    , 300},
    - = {    , 300},
   {,}= {    , 300}
    }
\microtypesetup{protrusion=true,expansion=true}
\ifPDFTeX\relax
\else
\newfontfeature{Microtype}{protrusion=default;expansion=default;}
\fi
}
\providecommand{\thechapter}{}
\providecommand{\chaptermark}{}

\DeclareOption{14pt}{
\renewcommand\su@scale{1.1667}
\renewcommand\baselinestretch{1.3} % WORKAROUND
}

\def\su@set@cambriamathfont{\setmathfont[
]{Cambria Math}%
}

\def\su@set@lmmathfont{\setmathfont[
]{latinmodern-math.otf}%
}

\def\su@set@asanamathfont{\setmathfont[
]{Asana-Math.otf}%
}

\def\su@set@eulermathfont{\setmathfont[
math-style=upright,
vargreek-shape=unicode
]{euler.otf}%
}

\newif\if@loadxitsmath\@loadxitsmathfalse
\newif\if@loadgostseventhreetwo\@loadgostseventhreetwofalse
\DeclareOption{xitsmath}{
\@loadxitsmathtrue
\def\su@set@mathfont{\su@set@xitsmathfont}
}

\DeclareOption{cambriamath}{
\def\su@set@mathfont{\su@set@cambriamathfont}
}

\DeclareOption{lmmath}{
\def\su@set@mathfont{\su@set@lmmathfont}
}

\DeclareOption{asanamath}{
\def\su@set@mathfont{\su@set@asanamathfont}
}

\newif\if@loadeulermath\@loadeulermathfalse
\DeclareOption{eulermath}{
\@loadeulermathtrue
\def\su@set@mathfont{\su@set@eulermathfont}
}

\DeclareOption{times}{
\ifPDFTeX\relax
\else
\setmainfont[
Scale=\su@scale,
ItalicFont=timesi.ttf,
BoldFont=timesbd.ttf,
BoldItalicFont=timesbi.ttf,
]{times.ttf}
\setmonofont[
Numbers=SlashedZero,
Scale=\su@scale,
ItalicFont=couri.ttf,
BoldFont=courbd.ttf,
BoldItalicFont=courbi.ttf,
]{cour.ttf}
\setsansfont[
% Scale=\su@scale,
ItalicFont=Fira Sans Italic,
BoldFont=Fira Sans Bold,
BoldItalicFont=Fira Sans Bold Italic,
]{Fira Sans Regular}
\fi
\renewcommand\sutypeface{Таймс}
}

\DeclareOption{freetimes}{
\setmainfont[Scale=\su@scale]{Free Times}
\setmonofont[Numbers=SlashedZero]{Free Courier}
\fi
\renewcommand\sutypeface{Таймс}
}

\DeclareOption{listbib}{
\renewcommand{\@biblabel}[1]{#1.}
}

\DeclareOption{firamono}{
\ifPDFTeX\relax
\else
\setmonofont[
Numbers=SlashedZero,
BoldFont=Fira Mono Bold
]{Fira Mono Regular}
\fi
}

\DeclareOption{firacode}{
\ifPDFTeX\relax
\else
\setmonofont[
Numbers=SlashedZero,
BoldFont=Fira Code Bold
]{Fira Code Regular}
\fi
}

\DeclareOption{firasans}{
\ifPDFTeX\relax
\else
\setsansfont[
BoldFont=FiraSans-Bold.otf,
ItalicFont=FiraSans-Italic.otf,
BoldItalicFont=FiraSans-BoldItalic.otf
]{FiraSans-Regular.otf}
\fi
}

\DeclareOption{inconsolata}{
%\setmonofont[Ligatures=TeX,Scale=MatchLowercase,Numbers=SlashedZero]{Inconsolata LGC}
\ifPDFTeX\relax
\else
\setmonofont[
%  Ligatures={TeX},
  Numbers=SlashedZero,
  % BoldFont="inconsolatalgcbold.ttf",
  % ItalicFont="inconsolatalgcitalic.ttf",
  % BoldItalicFont="inconsolatalgcbolditalic.ttf",
]{Inconsolata LGC Regular}
\fi
}

\DeclareOption{indenttitles}{
\def\su@title@indent{\parindent}
}

\DeclareOption{smalltitles}{
\def\su@sec@size{\large}
\def\su@subsec@size{\normalsize}
\def\su@subsubsec@size{\normalsize}
\renewcommand\su@chapter@font@size{\Large}
% \hyphenpenalty=10000 % to prevent hyps in headers
}

\DeclareOption{tinytitles}{
\def\su@sec@size{\normalsize}
\def\su@subsec@size{\normalsize}
\def\su@subsubsec@size{\normalsize}
\renewcommand\su@chapter@font@size{\normalsize}
\let\su@trans@func\MakeUppercase
% \hyphenpenalty=10000 % to prevent hyps in headers
}

\def\rename@732{}

\DeclareOption{732}{
  % GOST 7.32
  \@loadgostseventhreetwotrue
  \renewcommand{\contentsname}{СОДЕРЖАНИЕ}
  \pagestyle{plain}
  \renewcommand\bibsection{%
    \chapter{\bibname}%
    \@mkboth{\MakeUppercase{\bibname}}{\MakeUppercase{\bibname}}%
  }%
  \providecommand{\appendices}{}
  \renewcommand{\appendices}{%
    \renewcommand{\thechapter}{\Asbuk{chapter}}
    \setcounter{chapter}{0}
    \renewcommand\chaptername{ПРИЛОЖЕНИЕ}
    \renewcommand{\chapter@su@name}{ПРИЛОЖЕНИЕ}
    %\renewcommand\cftchappresnum{\chapter@su@name~}
  }
  \renewcommand{\thechapter}{\arabic{chapter}}
  \def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne%
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\chaptername\space\protect\numberline{\thechapter}#1}%
                    \else%
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi%
                    $ $\chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                      \fi}
\let\su@trans@func\MakeUppercase
\def\@makeschapterhead#1{%
  %\vspace*{30\p@}%
  {\parindent \z@ \centering
    \interlinepenalty\@M
    \hyphenpenalty\@M
    {\su@chapter@font@size \su@chapter@font \su@trans@func #1\par\nobreak}
    \vskip 15\p@ %% Here
  }}

\renewcommand\baselinestretch{1.2} % 1.5 looks bad
\setlength{\parindent}{1.27cm}
\let\su@sec@indent\parindent

\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode % \bfseries % Removed boldface in toc for chapter headers
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss \textbf{#2}}\par
      \penalty\@highpenalty
    \endgroup
    \fi}
\def\rename@732{%
\renewcommand{\bibname}{СПИСОК ИПОЛЬЗОВАННЫХ ИСТОЧНИКОВ}
\renewcommand{\contentsname}{СОДЕРЖАНИЕ}
\renewcommand{\chaptername}{}
}
}

\ExecuteOptions{14pt,times,cambriamath,%
  firacode,smalltitles,listbib,%
  732,microtyping,final}

%\ProcessKeyvalOptions{subook}\relax
\ProcessOptions\relax

\if@loadxitsmath
 \ifPDFTeX
  \RequirePackage{newtxmath}
 \fi
\fi

\if@loadeulermath
 \ifPDFTeX
 \RequirePackage{eulervm}
 \fi
\fi

\def\@makechapterhead#1{%
  {\parindent \z@ \raggedright \su@chapter@font
    \@hangfrom{%
    \ifnum \c@secnumdepth >\m@ne
        \su@chapter@font@size \su@chapter@font%
         %\ifx\@chapapp\empty
         \setbox0=\hbox{\@chapapp\unskip}%
         \ifdim\wd0=0pt
           \relax
         \else
           \@chapapp\space
         \fi
         \thechapter\hbox to 0.3em {}  % Trimmed here
        \nobreak
    \fi
    }%
    {\interlinepenalty\@M\hyphenpenalty\@M
    \su@chapter@font@size \su@chapter@font \su@trans@func #1\par\nobreak
    }
    \vskip 15\p@
    %\thispagestyle{empty}
  }}

\newcommand\sutitlefontface{\bfseries\scshape\Large}
\newcommand{\sutitletext}{\@title}
\newcommand\sutitle{%
\begin{center}%
{\sutitlefontface\foreignlanguage{russian}{\sutitletext}}
\end{center}}
\newcommand\sutitleex{%
{\@title}}
\newcommand\forename[1]{#1}
\newcommand\surname[1]{#1}

%microtype, flafter
% использовать Times New Roman (checked)

%Например, команда \enlargethispage{2\baselineskip} позволит текущей странице стать длиннее (выше) на две строчки. Вариант команды «со звёздочкой», \enlargethispage*{длина}, попытается сжать страницу насколько это возможно.


%\RequirePackage{listings} % Не работает с русскими комментариями.


%Основные требования для макетов в редакторе Тех
%Поля: верхнее – 1,8 см, нижнее – 2,8, левое и правое – 2,7
%Риасстояние от края страницы до колонтитула – 2,1 см

%\def\normalsize{\fontsize{15}{18}\selectfont{}}

%\renewcommand{\publishername}{Иркутский государственный технический университет}
%\renewcommand{\locationname}{Иркутск}

\@ifpackageloaded{amsthm}{}{
\theoremseparator{.}
}

\newenvironment{mygroup}{}{}

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
% - ISDCT SB RAS Dissertation package -----
%\renewcommand{\baselinestretch}{1.0}

% adjustenment of the title sizes.

%% %\renewcommand\ctfchapfont{\large\bf}
\renewcommand\cftpartnumwidth{3ex}
\providecommand\cftchapnumwidth{3ex}
\renewcommand\cftchapnumwidth{3ex}
\renewcommand\cftsecnumwidth{4ex}
\renewcommand\cftsubsecnumwidth{6ex}
\renewcommand\cftsubsubsecnumwidth{7ex}


\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi
                 \addcontentsline{toc}{chapter}{#1}% Added here
    %\thispagestyle{plain}%
        \@mkboth{%
           \MakeUppercase{#1}}{\MakeUppercase{#1}}%
}

\renewcommand\bibsection{%
\chapter*{\bibname}%
\@mkboth{\MakeUppercase{\bibname}}{\MakeUppercase{\bibname}}%
}%

\renewenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

% This is for the following table of contents printing
\def\@sschapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi
}

\hypersetup{
    bookmarks=true,         % show bookmarks bar?
    unicode=true,          % non-Latin characters in Acrobat’s bookmarks
    pdftoolbar=true,        % show Acrobat’s toolbar?
    pdfmenubar=true,        % show Acrobat’s menu?
    pdffitwindow=false,     % window fit to page when opened
    pdfstartview={FitH},    % fits the width of the page to the window
    pdftitle={Irkutsk State University Work},    % title
    pdfauthor={Some Outstanding ISU.RU Professor},     % author
    pdfsubject={The Subject},   % subject of the document
    pdfcreator={LaTeX},   % creator of the document
    pdfproducer={LaTeX}, % producer of the document
    pdfkeywords={Irkutsk State University}, % list of keywords
    pdfnewwindow=true,      % links in new window
    colorlinks=true,       % false: boxed links; true: colored links
    linkcolor=black, %[rgb]{0 0.4 0.1},          % color of internal links
    citecolor=black, %blue,        % color of links to bibliography
    filecolor=black,      % color of file links
    urlcolor=black % [rgb]{0.3 0.0 0.3}           % color of external links
}

%\setcounter{tocdepth}{1}  % Точность представления содержания
\setcounter{tocdepth}{3}  % Точность представления содержания

\DeclareCaptionLabelSeparator{dotnewline}{.\\}
\DeclareCaptionFormat{rightcenter}{\parbox{\linewidth}{{\raggedleft #1#2}\par {\centering #3}}}

%\renewcommand\@tempdima{60px}
\setlength{\footnotemargin}{0.5em}



\if@loadgostseventhreetwo
\geometry{paper=a4paper, includehead, left=2.5cm, right=1cm, top=1.8cm, bottom=2cm}
\let\headwidth=\textwidth
\fi

\ifPDFTeX\relax
\else
\su@set@mathfont%
\fi

\AtBeginDocument{
\pagenumbering{arabic}
\normalsize
\DeclareCaptionLabelSeparator{periodnewline}{.\\}
\DeclareCaptionLabelSeparator{ddash}{~--~}

\if@loadgostseventhreetwo

\captionsetup[figure]{labelformat=simple,labelsep=ddash,font=small,labelfont={small},textfont={small},format=hang,margin=3ex,justification=justified,singlelinecheck=false}
\captionsetup[table]{format=hang,labelsep=ddash,singlelinecheck=on,font={small},labelfont={small},textfont={small},labelfont={normalfont},justification=justified,skip=0.2ex}
% \captionsetup[table]{format=plain,labelsep=newline,singlelinecheck=off,justification=Centering} %%%% THIS IS just CENTERED
  \renewcommand\tablename{Таблица}
  \renewcommand\figurename{Рисунок}
  \renewcommand{\theequation}{\arabic{equation}}
\renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{\thechapter\ #1}}{\MakeUppercase{\thechapter\ #1}}}
\renewcommand{\sectionmark}[1]{\markright{\MakeUppercase{\thesection\ #1}}{}}
\pagestyle{plain}
%\pagestyle{fancy}
\renewcommand{\contentsname}{ОГЛАВЛЕНИЕ}

\else

\captionsetup[figure]{labelformat=simple,labelsep=period,font=small,labelfont={bf,small},textfont={small,it},format=hang,margin=3ex,justification=justified,singlelinecheck=false}
\captionsetup[table]{format=rightcenter,labelsep=periodnewline,singlelinecheck=on,font={normalfont},labelfont={small,bf},textfont={normalfont,it},justification=raggedleft,skip=0.2ex}
\renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{\thechapter.\ #1}}{\MakeUppercase{\thechapter.\ #1}}}
\renewcommand{\sectionmark}[1]{\markright{\MakeUppercase{\thesection.\ #1}}{}}

\fi

\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \@sschapter{\contentsname% Here the changes are
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
    %\thispagestyle{plain}%
    \thispagestyle{empty}%
    }%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }
\let\chaptername=\chapter@su@name
% \selectlanguage{russian}

\if@loadgostseventhreetwo

\if@cfthaspart
\renewcommand\cftpartaftersnum{}
\fi
\if@cfthaschapter
\renewcommand\cftchapaftersnum{}
\fi
\renewcommand\cftsecaftersnum{}
\renewcommand\cftsubsecaftersnum{}
\renewcommand\cftsubsubsecaftersnum{}

\else

\renewcommand\cftpartaftersnum{.}
\providecommand\cftchapaftersnum{.}
\renewcommand\cftchapaftersnum{.}
\renewcommand\cftsecaftersnum{.}
\renewcommand\cftsubsecaftersnum{.}
\renewcommand\cftsubsubsecaftersnum{.}

\fi

\rename@732
}

\renewcommand\section{\@startsection{section}{1}{\su@sec@indent}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\su@sec@title@font\su@sec@size\bfseries\hyphenpenalty\@M\interlinepenalty=50}}
\renewcommand\subsection{\@startsection{subsection}{2}{\su@sec@indent}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\su@sec@title@font\su@subsec@size\bfseries\hyphenpenalty\@M\interlinepenalty=50}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\su@sec@indent}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\su@sec@title@font\su@subsubsec@size\bfseries\hyphenpenalty\@M\interlinepenalty=50}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\su@par@title@font\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\su@par@title@font\normalsize\bfseries}}
\if@loadgostseventhreetwo

\renewcommand*{\@seccntformat}[1]{\csname the#1\endcsname ~~}

\else

\renewcommand*{\@seccntformat}[1]{\csname the#1\endcsname .~~}

\fi

\frenchspacing
\righthyphenmin=2
\lefthyphenmin=2

\fancypagestyle{plain}{%
\fancyhf{} % clear all header and footer fields
\fancyfoot[C]{\su@colonsize\thepage} % except the center
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}

\isu@defgeom{}
\normalsize

%%% Local Variables:
%%% mode: latex
%%% TeX-master: "dis"
%%% End:
