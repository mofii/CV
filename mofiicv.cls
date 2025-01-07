%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mofii CV
% LaTeX Class
% Version 1.1.0 (12/2/2024)
%
%
% Authors:
% Morten Engelsen (mofii)
%
% Based on a template by Jan Vorisek (jan@vorisek.me) which again 
% was based on works by Jan Küster (info@jankuester.com)
%
% License:
% The MIT License (see included LICENSE file)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mofiicv}[2024/11/20 v1.0.0]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}} 
\ProcessOptions\relax 
\LoadClass{extarticle}

%----------------------------------------------------------------------------------------
%	PACKAGES AND OTHER DOCUMENT CONFIGURATIONS
%----------------------------------------------------------------------------------------
\usepackage{siunitx} % units, but here only used for easy interface to table columns
\usepackage{enumitem}
\setitemize{noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt}
\setlength{\parindent}{0mm} % Suppress paragraph indentation
\pagestyle{empty} % No headers or footers
\usepackage{moresize} % Provides more font size commands (\HUGE and \ssmall)

%----------------------------------------------------------------------------------------
%	PAGE LAYOUT
%----------------------------------------------------------------------------------------
\usepackage{geometry} % Required for adjusting page dimensions and margins
\geometry{
	paper=letterpaper, % Paper size, change to letterpaper for US letter size
	top=0.5cm, % Top margin
	bottom=0.5	cm, % Bottom margin
	left=.5cm, % Left margin
	right=.5cm, % Right margin
	headheight=0.75cm, % Header height
	footskip=1cm, % Space from the bottom margin to the baseline of the footer
	headsep=0.5cm, % Space from the top margin to the baseline of the header
	%showframe, % Uncomment to show how the type block is set on the page
}
\usepackage{microtype}
%\usepackage{showframe}
\usepackage[english]{babel}
\hyphenation{le-ar-n-ing in-i-ti-ati-ve be-am-for-ming}
\usepackage{xcolor}
\definecolor{sand}{HTML}{C2B280}
\definecolor{sand2}{HTML}{dfd6cf}
\definecolor{gray2}{HTML}{e8e8e8}
\usepackage{calc}
\newlength{\FirstColumnWidth}
\setlength{\FirstColumnWidth}{0.3\textwidth}
\newlength{\ColSep}
\setlength{\ColSep}{1em}
\newlength{\SecondColumnWidth}
\setlength{\SecondColumnWidth}{\textwidth-\FirstColumnWidth-\ColSep-4pt}

%----------------------------------------------------------------------------------------
%	FONTS % Characters
%----------------------------------------------------------------------------------------
\usepackage[utf8]{inputenc} % Required for inputting international characters
\usepackage[T1]{fontenc} % Output font encoding for international characters
\usepackage[default]{raleway}
%\usepackage[defaultsans]{droidsans}
%\usepackage{cmbright}
%\usepackage{fetamont}
%\usepackage[default]{gillius}
%\usepackage{roboto}

\renewcommand*\familydefault{\sfdefault} % Force the sans-serif version of any font used
\usepackage{fontawesome} % Loads FontAwesome icons
% Command to insert a fontawesome icon
\newcommand{\icon}[1]{\csname fa#1\endcsname}




%----------------------------------------------------------------------------------------
%	GRAPHICS DEFINITIONS
%---------------------------------------------------------------------------------------- 
\usepackage{tikz}
\usetikzlibrary{shapes, backgrounds}
\tikzset{x=1cm, y=1cm} % Default tikz units

\newcommand{\columnbackground}{%
\begin{tikzpicture}[remember picture,overlay]
\fill[fill=sand2, opacity=0.3] (current page.south west) rectangle (\FirstColumnWidth+\ColSep*3/4,\paperheight);
\end{tikzpicture}
}


%----------------------------------------------------------------------------------------
%	CHARTS
%---------------------------------------------------------------------------------------- 

\newcommand{\tickandlabel}[2]{%
%#1: x location
%#2: label
\draw [densely dotted,very thick,color=gray!50] (#1,-\chartheight-\barsep/2) -- (#1 ,0);
%\draw [thick,color=black] (#1,-\chartheight-\barsep/2) -- 
%    (#1 ,-\chartheight+\barsep*2/3);
\node [label={[rotate=60, anchor=east]below:#2}] at (#1,-\chartheight) {};
}

\newcommand{\calcticklocation}[1]{
    \pgfmathparse{\tickstart+\tickspan*#1/4}
	\let#1\pgfmathresult
}

% Environment to hold a new bar chart
\newenvironment{barchart}[1]{
%#1: Maximum bar width, in cm
% This section is only run once
\newcounter{barcount}
	\newcommand{\barwidth}{0.35}
	\newcommand{\barsep}{0.2}
    \newcommand{\tickstart}{0}
    \newcommand{\tickend}{0}
    \newcommand{\tickspan}{0}
    \newcommand{\numticks}{5}
    \newcommand{\tickone}{0}
    \newcommand{\ticktwo}{1}
    \newcommand{\tickthree}{2}
    \newcommand{\tickfour}{3}
    \newcommand{\tickfive}{4}
    \newcommand{\chartheight}{0}

    % calc ticks start and end
    \pgfmathparse{#1}
	\let\barsize\pgfmathresult
    \let\tickend\barsize
    \pgfmathparse{\tickend*0.02}
	\let\tickstart\pgfmathresult
    \pgfmathparse{\tickend-\tickstart}
	\let\tickspan\pgfmathresult
    %calc each tick location
    \calcticklocation{\tickone}
    \calcticklocation{\ticktwo}
    \calcticklocation{\tickthree}
    \calcticklocation{\tickfour}
    \calcticklocation{\tickfive}

    
	% Command to add a bar to the bar chart
	\newcommand{\baritem}[2]{ 
    %#1: bar label
    %#2: bar width in percentage of chart width
		\pgfmathparse{##2}
		\let\perc\pgfmathresult
		\pgfmathparse{\tickstart+\tickspan*##2/4}
		\let\barone\pgfmathresult
		\pgfmathparse{(\barwidth*\thebarcount)+(\barsep*\thebarcount)}
		\let\barx\pgfmathresult
		
		\filldraw[fill=black, draw=none] (0,-\barx) rectangle (\barone,-\barx-\barwidth);
		
		\node [label=180:##1] at (0,-\barx-0.175) {};
		\addtocounter{barcount}{1}
	}
	\begin{tikzpicture}
		\setcounter{barcount}{0}
}{
    % This is run after end{document}
    \pgfmathparse{(\barwidth*\thebarcount)+(\barsep*\thebarcount)}
	\let\chartheight\pgfmathresult  
    \tickandlabel{\tickone}{Novice}
    \tickandlabel{\ticktwo}{Basic}
    \tickandlabel{\tickthree}{Proficient}
    \tickandlabel{\tickfour}{Advanced}
    \tickandlabel{\tickfive}{Expert}
	\end{tikzpicture}
}

%----------------------------------------------------------------------------------------
%	CUSTOM SECTIONS
%----------------------------------------------------------------------------------------
\usepackage[noindentafter,explicit]{titlesec}
\setcounter{secnumdepth}{0} % no section numbers
\titleformat{\section}[display]
{\normalfont\large\bfseries}
{}
{5pt}
{#1\hspace{1ex}\titlerule[.6pt]}

\titleformat{name=\subsection}[runin]
  {\bf\uppercase}
  {}
  {}
  {#1}

\titlespacing{\section}{0em}{1em}{0.5em}
\titlespacing{\subsubsection}{0em}{0.5em}{1em}[1em]

%----------------------------------------------------------------------------------------
%	ENTRY LIST
%----------------------------------------------------------------------------------------
\usepackage{longtable} % Required for tables that span multiple pages
\setlength{\LTpre}{0pt} % Remove default whitespace before longtable
\setlength{\LTpost}{0pt} % Remove default whitespace after longtable
\setlength{\tabcolsep}{1pt} % No spacing between table columns

% Environment to hold a new list of entries
\newenvironment{entrylist}{
	\begin{longtable}[H]{l l}
}{
	\end{longtable}
}

\newcommand{\entry}[4]{% First argument for the leftmost date(s) text, second is for the bold entry heading, third is for the bold right-aligned entry qualifier and the fourth is for the entry description
	\parbox[t]{0.175\textwidth}{% 17.5% of the text width of the page
		#1 % Leftmost entry date(s) text
	}%
	&\parbox[t]{0.825\textwidth}{% 82.5% of the text width of the page
		\textbf{#2}% Entry heading text
		\hfill% Horizontal whitespace
		{\footnotesize \textbf{\textcolor{black}{#3}}}\\% Right-aligned entry qualifier text
		{\setlength{\parindent}{1em}#4} % Entry description text
	}\\\\}

% Command to output a separator slash between lists, e.g. '  /  '
\newcommand{\slashsep}{\hspace{1em}/\hspace{1em}}

% Keep hyp as last package, as it hooks into other packages.
\usepackage[hidelinks]{hyperref} % Required for links but hide the default boxes around links
