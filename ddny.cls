%% ddny.cls
%% LaTeX document class pro Proceedings workshopu 'Doktorandske dny na KM FJFI'
%% Autor: Petr Ambroz <petr.ambroz@fjfi.cvut.cz>
%% verze: 0.32
%%
%% ---------------------------------------------------------------------------------
%%
%% Changelog
%% *0.1 07/2006  
%%           Prvni verze zasilana s pokyny pro Doktorandske dny 2006
%% *0.2 10/2006  
%%           FIX) meziodstavcove mezery ve finalni verzi
%%           FIX) prepinani jazykove zavislych elementu ve finalni verzi
%%           ADD) zahlavi na praznych stranach pri volbe openright
%%           FIX) nulovani citace tabulek a obrazku
%%           FIX) nulovani footnote counteru pred sazenim thanks poznamek 
%%           ADD) \frontmatter a \mainmatter
%%	     FIX) rozdeleny nazev fakulty v anglicke verzi afilace autoru
%% *0.21 05/2007
%%           FIX) drobne zmeny ve formatovani instituci
%%	     FIX) \fjfiname Science -> Sciences
%% *0.22 10/2009
%%           ADD) \nohyphens
%%           FIX) running title se defaultne bere z title
%% *0.23 09/2010
%%           ADD) KF a KSE jako mozne afiliace studentu
%% *0.24 10/2010
%%           ADD) prostredi pro sazbu seznamu klicovych slov
%% *0.25 10/2010
%%           FIX) automaticka protekce \thanks v \title a \author
%% *0.26 10/2013
%%           FIX) novy nazev katedry KSE
%% *0.3	 10/2013
%%           ADD) je mozne mit 1-3 skolitele
%% *0.31 10/2013
%%	     ADD) running verze jmena autora se generuje automaticky
%% *0.32 10/2014
%%	     FIX) running title zahazuje \thanks pouzity v title
%%	     FIX) automaticke generovani running author funguje i pri pouzitem thanks v \author
%% *0.33 10/2017
%%	     ADD) prostredi 'full' pro referenci na plnou verzi clanku je-li zaslan pouze extended abstrakt

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ddny}[2017/10/03 v0.33 DDny Proceedings]

\LoadClass[a4paper,12pt,twoside]{article}
\RequirePackage{ifthen,hyphenat,calc,url,ifoddpage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Volby balicku

\newif\if@openright\@openrightfalse
\newif\if@ddny@heads\@ddny@headsfalse
\newif\if@babel\@babelfalse
\newif\if@czechauto\@czechautofalse
\newif\if@slovakauto\@slovakautofalse

\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\DeclareOption{heads}{\@ddny@headstrue}
\DeclareOption{noheads}{\@ddny@headsfalse}
\DeclareOption{babel}{\@babeltrue}
\DeclareOption{nobabel}{\@babelfalse}
\DeclareOption{czech}{\@babeltrue\@czechautotrue}
\DeclareOption{slovak}{\@babeltrue\@slovakautotrue}

\ExecuteOptions{openany,noheads,nobabel}
\ProcessOptions

\if@babel
  \RequirePackage[czech,slovak,english]{babel}
\fi

\if@ddny@heads
  \RequirePackage{xstring}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vzhled strany

%% Rozmery

%% vertikalni
\setlength{\textheight}{661pt}
\setlength{\headheight}{15pt}
\setlength{\headsep}{25pt}
\setlength{\topmargin}{(\paperheight-\textheight-\headheight-\headsep-\footskip)/2 - 1in}

%% horizontalni
\setlength{\textwidth}{453pt}
\setlength\oddsidemargin{(\paperwidth-\textwidth)/2 - 1in}
\setlength\evensidemargin{(\paperwidth-\textwidth)/2 - 1in}

%% Cislovani a zahlavi

\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{%
      \underline{\rule[-2pt]{0pt}{4pt}%
      \makebox[\textwidth]{\hskip 2pt\thepage\hfill\slshape\leftmark\hskip 2pt}}}
    \def\@oddhead{%
      \underline{\rule[-2pt]{0pt}{4pt}%
      \makebox[\textwidth]{\hskip 2pt{\slshape\rightmark}\hfill\thepage\hskip 2pt}}}
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble}

\def\ps@myemptyheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{%
      \underline{\rule[-2pt]{0pt}{4pt}%
      \makebox[\textwidth]{\hskip 2pt\thepage\hfill}}}
    \def\@oddhead{%
      \underline{\rule[-2pt]{0pt}{4pt}%
      \makebox[\textwidth]{\hfill\thepage\hskip 2pt}}}
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble}

\pagestyle{myheadings}

\newcommand{\frontmatter}{%
  \pagestyle{empty}}

\newcommand{\mainmatter}{%
  \pagestyle{myheadings}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  List of papers

\def\l@paper{\@dottedtocline{1}{1.5em}{2.3em}}

\def\@listofpapers@pretoc{%
  {\LARGE\textbf{Seznam p\v{r}\'isp\v{e}vk\r{u}}\par\vspace{0.5em}}}

\def\@listofpapers@posttoc{%
  \setlength{\parskip}{0pt}}

\def\listofpapers{%
  \setlength{\parskip}{0.5\baselineskip}%
  \IfFileExists{\jobname .lop}{\@listofpapers@pretoc}{}%
  \@starttoc{lop}%
  \IfFileExists{\jobname .lop}{\@listofpapers@posttoc}{}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Jazykove zavisle elementy

\newcommand{\yearname}{year of}
\newcommand{\advisorname}{advisor}
\newcommand{\advisorsname}{advisors}
\newcommand{\fjfiname}{Department of Mathematics\\%
  Faculty of Nuclear Sciences and Physical Engineering, CTU in Prague}
\newcommand{\kmname}{Department of Mathematics\\%
  Faculty of Nuclear Sciences and Physical Engineering, CTU in Prague}
\newcommand{\kfname}{Department of Physics\\%
  Faculty of Nuclear Sciences and Physical Engineering, CTU in Prague}
\newcommand{\ksename}{Department of Software Engineering\\%
  Faculty of Nuclear Sciences and Physical Engineering, CTU in Prague}
  
\newcommand{\utianame}{Institute of Information Theory and Automation, CAS}
\newcommand{\uiname}{Institute of Computer Science, CAS}

\if@babel
  \addto\captionenglish{%
    \renewcommand{\yearname}{year of}  
    \renewcommand{\advisorname}{advisor}
    \renewcommand{\advisorsname}{advisors}
    \renewcommand{\fjfiname}{Department of Mathematics\\%
      Faculty of Nuclear Sciences and Physical Engineering, CTU in Prague}
    \renewcommand{\kmname}{Department of Mathematics\\%
      Faculty of Nuclear Sciences and Physical Engineering, CTU in Prague}
    \renewcommand{\kfname}{Department of Physics\\%
      Faculty of Nuclear Sciences and Physical Engineering, CTU in Prague}
    \renewcommand{\ksename}{Department of Software Engineering\\ %
      Faculty of Nuclear Sciences and Physical Engineering, CTU in Prague}
    \renewcommand{\refname}{References}}

  \addto\captionsczech{%
    \renewcommand{\yearname}{ro\v{c}n\'ik}
    \renewcommand{\advisorname}{\v{s}kolitel}
    \renewcommand{\advisorsname}{\v{s}kolitel\'e}    
    \renewcommand{\fjfiname}{Katedra matematiky\\%
      Fakulta jadern\'a a fyzik\'aln\v{e} in\v{z}en\'yrsk\'a, \v{C}VUT v Praze}
    \renewcommand{\kmname}{Katedra matematiky\\%
      Fakulta jadern\'a a fyzik\'aln\v{e} in\v{z}en\'yrsk\'a, \v{C}VUT v Praze}
    \renewcommand{\kfname}{Katedra fyziky\\%
      Fakulta jadern\'a a fyzik\'aln\v{e} in\v{z}en\'yrsk\'a, \v{C}VUT v Praze}
    \renewcommand{\ksename}{Katedra softwarov\'eho in\v{z}en\'yrstv\'i\\%
      Fakulta jadern\'a a fyzik\'aln\v{e} in\v{z}en\'yrsk\'a, \v{C}VUT v Praze}
    \renewcommand{\refname}{Literatura}}

  \addto\captionsslovak{%
    \renewcommand{\yearname}{ro\v{c}n\'ik}  
    \renewcommand{\advisorname}{\v{s}kolite\v{l}}
    \renewcommand{\advisorsname}{\v{s}kolite\v{l}\'e}
    \renewcommand{\fjfiname}{Katedra matematiky\\%
      Fakulta jadrov\'a a fyzik\'alne in\v{z}inierska, \v{C}VUT v Praze}
    \renewcommand{\kmname}{Katedra matematiky\\%
      Fakulta jadrov\'a a fyzik\'alne in\v{z}inierska, \v{C}VUT v Praze}
    \renewcommand{\kfname}{Katedra fyziky\\%
      Fakulta jadrov\'a a fyzik\'alne in\v{z}inierska, \v{C}VUT v Praze}
    \renewcommand{\ksename}{Katedra softwarov\'eho in\v{z}inierstva\\%
      Fakulta jadrov\'a a fyzik\'alne in\v{z}inierska, \v{C}VUT v Praze}
    \renewcommand{\refname}{Literat\'ura}}
\fi

\newcommand{\changelangconst}{%
  \iflanguage{english}{%
    \renewcommand{\yearname}{year of}
    \renewcommand{\advisorname}{advisor}
    \renewcommand{\advisorsname}{advisors}
    \renewcommand{\fjfiname}{Department of Mathematics, %
      Faculty of Nuclear Sciences and Physical\\ Engineering, CTU in Prague}
    \renewcommand{\kmname}{Department of Mathematics, %
      Faculty of Nuclear Sciences and Physical\\ Engineering, CTU in Prague}
    \renewcommand{\kfname}{Department of Physics, %
      Faculty of Nuclear Sciences and Physical\\ Engineering, CTU in Prague}
    \renewcommand{\ksename}{Department of Software Engineering, %
      Faculty of Nuclear Sciences and Physical\\ Engineering, CTU in Prague}
    \renewcommand{\refname}{References}}{}
  \iflanguage{czech}{%
    \renewcommand{\yearname}{ro\v{c}n\'ik}
    \renewcommand{\advisorname}{\v{s}kolitel}
    \renewcommand{\advisorsname}{\v{s}kolitel\'e}
    \renewcommand{\fjfiname}{Katedra matematiky, %
      Fakulta jadern\'a a fyzik\'aln\v{e} in\v{z}en\'yrsk\'a, \v{C}VUT v Praze}
    \renewcommand{\kmname}{Katedra matematiky, %
      Fakulta jadern\'a a fyzik\'aln\v{e} in\v{z}en\'yrsk\'a, \v{C}VUT v Praze}
    \renewcommand{\kfname}{Katedra fyziky, %
      Fakulta jadern\'a a fyzik\'aln\v{e} in\v{z}en\'yrsk\'a, \v{C}VUT v Praze}
    \renewcommand{\ksename}{Katedra softwarového inženýrství, %
      Fakulta jadern\'a a fyzik\'aln\v{e} in\v{z}en\'yrsk\'a, \v{C}VUT v Praze}
    \renewcommand{\refname}{Literatura}}{}
  \iflanguage{slovak}{%
    \renewcommand{\yearname}{ro\v{c}n\'ik}  
    \renewcommand{\advisorname}{\v{s}kolite\v{l}}
    \renewcommand{\advisorsname}{\v{s}kolite\v{l}\'e}
    \renewcommand{\fjfiname}{Katedra matematiky, %
      Fakulta jadrov\'a a fyzik\'alne in\v{z}inierska, \v{C}VUT v Praze}
    \renewcommand{\kmname}{Katedra matematiky, %
      Fakulta jadrov\'a a fyzik\'alne in\v{z}inierska, \v{C}VUT v Praze}
    \renewcommand{\kfname}{Katedra fyziky, %
      Fakulta jadrov\'a a fyzik\'alne in\v{z}inierska, \v{C}VUT v Praze}
    \renewcommand{\ksename}{Katedra softwarového inžinierstva, %
      Fakulta jadrov\'a a fyzik\'alne in\v{z}inierska, \v{C}VUT v Praze}
    \renewcommand{\refname}{Literat\'ura}}{}}

  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  maketitle

\let\oldthanks\thanks
\renewcommand{\thanks}{\protect\oldthanks}

%\renewcommand*{\author}[5][ra]{%
%  \gdef\@author{#2}%
%  \gdef\@katedra{#3}%
%  \gdef\@rocnik{#4}%
%  \gdef\@email{#5}%
%  \if@ddny@heads
%    \ifthenelse{\equal{#1}{ra}}%
%      {\StrCut{#2}{ }\@authorjm\@authorpr%
%      \StrLeft{\@authorjm}{1}[\@authorjmini]%
%      \gdef\@authorrunning{\@authorjmini.~\@authorpr}}
%    {\gdef\@authorrunning{#1}}
%  \else
%    \gdef\@authorrunning{}
%  \fi}

\if@ddny@heads
    \renewcommand*{\author}[5][ra]{%
	\gdef\@author{#2}%
	\gdef\@katedra{#3}%
	\gdef\@rocnik{#4}%
	\gdef\@email{#5}%
	\ifthenelse{\equal{#1}{ra}}%
	    {\noexpandarg%
	    \StrCut{#2}{\thanks}\@authorclean\@authorthanks%
	    \fullexpandarg%
	    \StrCut{\@authorclean}{ }\@authorjm\@authorpr%
    	    \StrLeft{\@authorjm}{1}[\@authorjmini]%
    	    \gdef\@authorrunning{\@authorjmini.~\@authorpr}}%
    	    {\gdef\@authorrunning{#1}}}%
\else
    \renewcommand*{\author}[5][ra]{%
	\gdef\@author{#2}%
	\gdef\@katedra{#3}%
	\gdef\@rocnik{#4}%
	\gdef\@email{#5}%
	\gdef\@authorrunning{}}
\fi

\newcounter{NumberOfAdvisors}

\newcommand{\@advisori}{}
\newcommand{\@advisorii}{}
\newcommand{\@advisoriii}{}

\newcommand*{\advisor}[1]{%
	\stepcounter{NumberOfAdvisors}%
	\expandafter\renewcommand\expandafter{\csname @advisor\roman{NumberOfAdvisors}\endcsname}{#1}}

\newcounter{NumberOfInstitutions}

\newcommand{\@insti}{}
\newcommand{\@instii}{}
\newcommand{\@instiii}{}

\newcommand*{\inst}[1]{%
	\stepcounter{NumberOfInstitutions}
	\expandafter\renewcommand\expandafter{\csname @inst\roman{NumberOfInstitutions}\endcsname}{#1}}

%\renewcommand*{\title}[2][]{%
%  \gdef\@title{#2}%
%  \ifthenelse{\equal{#1}{}}%
%  {\gdef\@titlerunning{#2}}%
%  {\gdef\@titlerunning{#1}}}


\if@ddny@heads
    \renewcommand*{\title}[2][]{%
	\gdef\@title{#2}%
	\ifthenelse%
	    {\equal{#1}{}}%
	    {\noexpandarg%
	    \StrCut{#2}{\thanks}\@titleclean\@titlethanks
	    \expandarg%
	    \StrSubstitute\@titleclean{\noexpand\\}{}[\@titlecleaner]%
	    \fullexpandarg%
	    \gdef\@titlerunning{\@titlecleaner}}%
	    {\gdef\@titlerunning{#1}}}
\else
    \renewcommand*{\title}[2][]{%
	\gdef\@title{#2}%
	\gdef\@titlerunning{}}
\fi

\renewcommand{\maketitle}{%
  \if@czechauto
    \selectlanguage{czech}
  \fi
  \if@slovakauto
    \selectlanguage{slovak}
  \fi
  \begingroup%
    \setcounter{footnote}{0}%
    \renewcommand{\thefootnote}{\fnsymbol{footnote}}%
    \@maketitle%
    \@thanks%
  \endgroup%
  \addcontentsline{lop}{paper}{\@titlerunning\\*\textit{\@authorrunning}}%
  \setcounter{footnote}{0}%
  \setcounter{section}{0}%
  \setcounter{equation}{0}%
  \setcounter{figure}{0}%
  \setcounter{table}{0}%
  \setcounter{\@eqcnt@name}{0}%
  \if@ddny@heads
    \markboth{\@authorrunning}{\@titlerunning}%
  \fi
  \global\let\thanks\relax%
  \global\let\maketitle\relax%
  \global\let\@thanks\@empty%
  \global\let\@author\@empty%
  \global\let\@email\@empty%
  \global\let\@rocnik\@empty%
  \global\let\@katedra\@empty%  
  \global\let\@date\@empty%
  \global\let\@title\@empty%
%  \global\let\@advisor\@empty%
%  \global\let\@inst\@empty%
  \global\let\title\relax%
  \global\let\author\relax%
  \global\let\date\relax}

\newcounter{emptycnt}
\newcommand*{\@eqcnt@name}{emptycnt}

\newcommand{\@rok}{%
\if@babel
  \iflanguage{english}{%
    \ifthenelse{\equal{\@rocnik}{1}}{\@rocnik{st} \yearname}{%
      \ifthenelse{\equal{\@rocnik}{2}}{\@rocnik{nd} \yearname}{%
        \ifthenelse{\equal{\@rocnik}{3}}{\@rocnik{rd} \yearname}{%
          \@rocnik{th} \yearname}}}}
  {\@rocnik{.} \yearname}
\else
  \ifthenelse{\equal{\@rocnik}{1}}{\@rocnik{st} \yearname}{%
    \ifthenelse{\equal{\@rocnik}{2}}{\@rocnik{nd} \yearname}{%
      \ifthenelse{\equal{\@rocnik}{3}}{\@rocnik{rd} \yearname}{%
        \@rocnik{th} \yearname}}}
\fi}

\def\@maketitle{%
  \if@openright
    \clearpage
    \ifthenelse{\isodd{\thepage}}{}{\mbox{}\thispagestyle{myemptyheadings}\newpage}
  \else
    \clearpage
  \fi
  \null
  \thispagestyle{plain}%
  \vspace*{-36pt}%
  \noindent{\LARGE\raggedright\textbf{\@title}\par}%
  \vskip 2.5em%
  \begin{quotation}
  \noindent%
  {\large\lineskip .5em \@author\\[1em]}%
  \@rok PGS, email: \texttt{\@email}\\%
  \ifthenelse{\equal{\@katedra}{kf}}%
  {\nohyphens{\kfname}}%
  {\ifthenelse{\equal{\@katedra}{kse}}
   {\nohyphens{\ksename}}%
   {\nohyphens{\kmname}}}\\[2mm]%
  \ifnum\value{NumberOfAdvisors}=1
	\advisorname:~\@advisori, \nohyphens{\@insti}\par%
  \else
	\ifnum\value{NumberOfAdvisors}=2
	\advisorsname:\\[1mm]
	\@advisori, \nohyphens{\@insti}\\[1mm]%
	\@advisorii, \nohyphens{\@instii}\par%
    \else
    \advisorsname:\\[1mm]
	\@advisori, \nohyphens{\@insti}\\[1mm]%
	\@advisorii, \nohyphens{\@instii}\\[1mm]
	\@advisoriii, \nohyphens{\@instiii}\par%
    \fi
  \fi  
  \end{quotation}
  \vskip 1em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Abstrakt a klicova slova

\renewenvironment{abstract}[1]{%
  \small%
  \ifthenelse{\equal{#1}{english}}%
  {\noindent\textbf{Abstract.}}%
  {\noindent\textbf{Abstrakt.}}}%
  {\vskip 0.5em}

\newenvironment{keywords}[1]{%
  \small%
  \ifthenelse{\equal{#1}{english}}%
  {\noindent\textit{Keywords:}}%
  {\ifthenelse{\equal{#1}{czech}}%
  {\noindent\textit{Kl\'i\v{c}ov\'a slova:}}%
  {\noindent\textit{K\v{l}\'u\v{c}ov\'e slov\'a:}}}}%       Kľúčové slová
  {\vskip 0.5em}

\newenvironment{full}[1]{%
  \vskip0.5em%
  \ifthenelse{\equal{#1}{english}}%
  {\noindent\textbf{Full paper:}}%
  {\ifthenelse{\equal{#1}{czech}}%
  {\noindent\textbf{Pln\'a verze:}}%
  {\noindent\textbf{Pln\'a verzia:}}}}%       
  {\vskip 0.5em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% definice makra pro české uvozovky:

\def\@bq{\mbox{\kern.1ex\protect\raisebox{-1.3ex}[0pt][0pt]{''}\kern-.1ex}}
\def\@eq{\mbox{\kern-.1ex``\kern.1ex}}
\def\ifundefined#1{\expandafter\ifx\csname#1\endcsname\relax }%
\ifundefined{uv}%
  \gdef\uv#1{\@bq #1\@eq}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Prikazy pro zaverecnou sazbu

\newcommand*{\paper}[2][]{%
  \ifthenelse{\equal{#1}{}}{}{\selectlanguage{#1}\changelangconst}%
  \begingroup%
  \input{#2}%
  \endgroup}

\newcommand*{\eqcnt}[1]{%
  \renewcommand*{\@eqcnt@name}{#1}}

\newcommand*{\addpage}{%
  \newpage\thispagestyle{empty}\mbox{}}

\AtEndDocument{%
}

%%% end of ddny.cls
