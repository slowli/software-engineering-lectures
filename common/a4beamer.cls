%%
%% Enhanced beamer class for A4-paper presentations.
%% (c) 2013-2014, Alexei Ostrovski
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{a4beamer}[2013/10/13 A4 beamer class]

\usepackage{kvoptions}
\SetupKeyvalOptions{family=aiv,prefix=aiv@}

\DeclareStringOption[russian]{lang}
\DeclareStringOption[17pt]{scale}
\DeclareStringOption[a4]{page}

\ProcessKeyvalOptions*

\newif\ifprintout \printoutfalse
\def\@tempa{printout}
\ifx\aiv@page\@tempa
	\printouttrue
	\PassOptionsToClass{printout}{beamer}
\else
	\def\@tempa{a4}
\fi
\PassOptionsToClass{\aiv@scale}{beamer}
\PassOptionsToClass{\aiv@lang}{beamer}
\LoadClass[unicode,compress]{beamer}

% Geometry package is loaded by beamer
\def\@tempa{a4}
\ifx\aiv@page\@tempa
	\geometry{a4paper,landscape}
\fi
\ifprintout
	% TODO don't use geometry to rescale
	\geometry{a4paper,landscape}
	\RequirePackage{pgfpages}
	\pgfpagesuselayout{resize to}[a4paper,border shrink=1cm,landscape]
\fi

\ifprintout
	\usecolortheme{dove}
\else
	\usecolortheme{whale}
\fi

\useoutertheme[subsection=false]{miniframes}
\setbeamercolor{titlelike}{parent=structure}
\usefonttheme{professionalfonts}

\setbeamerfont{section in head/foot}{size=\small}
\setbeamerfont{subsection in head/foot}{size=\footnotesize}

%% Define footline

\def\@lecturetitle{}
\def\lecturetitle#1{\gdef\@lecturetitle{#1}}

\def\numbertemplate#1#2{%
	#1\,/\,#2%
}

\defbeamertemplate*{footline}{title and page}{
	\begin{beamercolorbox}[rightskip=0pt]{title in head/foot}%
		\vskip .4ex%
		\hskip .5em%
		\ifnum\thepage > 1%
			\@lecturetitle%
		\fi%
		\strut{}%
		\hfill%
		\begin{beamercolorbox}[center,wd=5em]{author in head/foot}%
			\strut{}%
			\usebeamerfont{page number in head/foot}%
			\numbertemplate{\insertframenumber}{\inserttotalframenumber}%
		\end{beamercolorbox}%
		\kern .5em%
		\vskip .4ex%
	\end{beamercolorbox}%
}

\setbeamercolor{footline}{parent=palette primary}
\setbeamerfont{footline}{size=\footnotesize}
\setbeamercolor{page number in head/foot}{parent=footline}
\setbeamerfont{page number in head/foot}{parent=footline}

%% Redefine miniframes to enable scalability
\RequirePackage{calc}

\newdimen\miniframesize
\newdimen\miniframeradius
\newdimen\miniframepadding
\miniframesize=0.6ex
\miniframepadding=0.2ex
\setlength{\miniframeradius}{\miniframesize/2}

\defbeamertemplate{mini frame}{large}{%
	\begin{pgfpicture}{0pt}{0pt}{\miniframesize}{\miniframesize}
		\pgfpathcircle{\pgfpoint{\miniframeradius}{\miniframeradius}}{\miniframeradius}
		\pgfusepath{fill,stroke}
	\end{pgfpicture}%
}
\defbeamertemplate{mini frame in current section}{large}{%
	\begin{pgfpicture}{0pt}{0pt}{\miniframesize}{\miniframesize}
		\pgfpathcircle{\pgfpoint{\miniframeradius}{\miniframeradius}}{\miniframeradius}
		\pgfusepath{stroke}
	\end{pgfpicture}%
}
\defbeamertemplate{mini frame in current subsection}{large}{%
	\begin{pgfpicture}{0pt}{0pt}{\miniframesize}{\miniframesize}
		\pgfpathcircle{\pgfpoint{\miniframeradius}{\miniframeradius}}{\miniframeradius}
		\pgfusepath{stroke}
	\end{pgfpicture}%
}

\setbeamertemplate{mini frames}[large]
\setlength{\@tempdima}{\miniframesize+\miniframepadding}
\setbeamersize{
	mini frame size=\@tempdima,
	text margin left=1.75em,
	text margin right=1.75em	
}

%% Define frame titles

\newdimen\frametitlesep \frametitlesep=0pt
\defbeamertemplate*{frametitle}{scalable}[1][left]{
  \ifbeamercolorempty[bg]{frametitle}{}{\nointerlineskip}%
  \@tempdima=\textwidth%
  \advance\@tempdima by\beamer@leftmargin%
  \advance\@tempdima by\beamer@rightmargin%
  \begin{beamercolorbox}[sep=\frametitlesep,#1,wd=\the\@tempdima]{frametitle}
    \usebeamerfont{frametitle}%
    \vbox{}\vskip-1ex%
    \if@tempswa\else\csname beamer@fte#1\endcsname\fi%
    \hskip 0.5em\strut\insertframetitle\strut\par%
    {%
      \ifx\insertframesubtitle\@empty%
      \else%
      {\usebeamerfont{framesubtitle}\usebeamercolor[fg]{framesubtitle}\insertframesubtitle\strut\par}%
      \fi
    }%
    \vskip-1ex%
    \if@tempswa\else\vskip-\frametitlesep\fi% set inside beamercolorbox... evil here...
  \end{beamercolorbox}%
}

%% Alerted list item
\newenvironment{alertitemenv}%
	{\only{%
		\setbeamercolor{item}{fg=red,bg=white}%
		\setbeamerfont{enumerate item}{series=\bfseries}%
	}}%
	{}

%% Disable navigation symbols
\setbeamertemplate{navigation symbols}{}

\RequirePackage[%
	lang=\aiv@lang
]{xtensions}

\renewcommand{\baselinestretch}{1.35}

\def\th@plain{\normalfont}
\newtheorem{Hypothesis}[theorem]{\hypothesisname}

