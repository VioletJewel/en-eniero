% Author: Violet Jewel

% ------------
% CLASS CONFIG
% ------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{engxeniero}[sep 2024 enĝeniero vk klaso V1.0]

% pass through any options to the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}

% process given options
\ProcessOptions\relax

% load base class
\LoadClass{extarticle}

% --------
% PACKAGES
% --------

% for adjusting page dimensions & margins with \geometry
\usepackage{geometry}

% for \href links
%   - hide boxes around links
%   - don't color links
\usepackage[colorlinks=false,hidelinks]{hyperref}

% for calculating lengths
\usepackage{calc}

% for customizing section titles with \titleformat
\usepackage{titlesec}

% for making tables with fixed width columns with tabularx environment
\usepackage{tabularx}

% for adjusting table line space with \addlinespace
\usepackage{booktabs}

% for multi-row rows in tables with \multirow
\usepackage{multirow}

% for changing the table's color properties with \arrayrulecolor
\usepackage{colortbl}

%  for images with \includegraphics
\usepackage{graphicx}

% % for math
% \usepackage{amsmath}

% for underlining text with \uline
\usepackage{ulem}

% for contouring text
\usepackage{contour}

% for floating text on the page with \LenToUnit
\usepackage[pscoord]{eso-pic}

% for FontAwesome icons with \fa*
\usepackage{fontawesome}

% for coloring text with \color, etc
\usepackage[dvipsnames]{xcolor}

% for customizing lists
\usepackage{enumitem}

% Provides more font size commands (\HUGE and \ssmall)
\usepackage{moresize}

% ---------------
% DOCUMENT CONFIG
% ---------------

\makeatletter

\AtBeginDocument{
  \hypersetup{
    pdftitle = {\@author's CV},
    pdfauthor = {\@author},
    pdfcreator = {\@author},
  }
}

\geometry{
  paper=letterpaper, % paper size, use a4paper for non-US paper size
  % ignoreheadfoot,    % set margins without considering header and footer
  top=1.3 cm,        % top margin
  bottom=1.3 cm,     % bottom margin
  left=1.7 cm,       % left margin
  right=1.3 cm,      % right margin
  footskip=0.0 cm,   % seperation between body and footer
  headsep=0.5cm,     % Space from the top margin to the baseline of the header
  % showframe          % for debugging
}

% light blue color for href links
\definecolor{href@lightblue}{RGB}{130, 190, 250}

% no section numbering
\setcounter{secnumdepth}{0}

% no indentation
\setlength{\parindent}{0pt}

% no page numbering
\pagenumbering{gobble}

% suppress paragraph indentation
\setlength{\parindent}{0mm}

\titleformat{\section}{\bfseries\scshape\Large}{}{}{}[\titlerule]

% Section Spacing:      left         top         bottom
\titlespacing{\section}{-.4 cm}{0 cm + 5pt}{0 cm + 5pt}

% custom bullet points
\renewcommand\labelitemi{$\vcenter{\hbox{\small$\bullet$}}$\hspace{-1mm}}

% -----
% FONTS
% -----

\usepackage[default]{raleway}
%\usepackage[defaultsans]{droidsans}
%\usepackage{cmbright}
%\usepackage{fetamont}
%\usepackage[default]{gillius}
%\usepackage{roboto}

% force sans-serif for any font used
\renewcommand*\familydefault{\sfdefault}

\ifPDFTeX
  \input{glyphtounicode}
  \pdfgentounicode=1
  \usepackage[T1]{fontenc}
  \usepackage[utf8]{inputenc}
\fi

% --------
% COMMANDS
% --------

% Author's name in large, bold lettering
% >> \begin{center} \name \end{center}  % or \name[fontsize]
\newcommand{\name}[1][25pt]{%
  \begingroup%
  \fontsize{#1}{#1}\selectfont\textbf{\vphantom{\strut}\@author}%
  \endgroup%
}

% contact info bar with separators and kerning
% >> \info  % or \info[kerning amount]
% >> {\faGlobe \, South Pole, Antarctica}
% >> {\href{mailto:elva@santelfmail.com}{\faEnvelopeO \, elva@SantElfMail}}
% >> ...
% >> \par
\newcommand\info[2][2mm]{%
  \newcommand\info@kern{#1}%
  \newcommand\info@checknext{\@ifnextchar\bgroup{\info@next}{}}%
  \newcommand{\header@info}[1]{\vphantom{\strut}\mbox{##1}\info@checknext}%
  \newsavebox\info@ANDbox%
  \sbox\info@ANDbox{$|$}%
  \newcommand\info@next[1]{%
    \kern\info@kern{%
      \unskip\cleaders\copy\info@ANDbox\hskip\wd\info@ANDbox\ignorespaces%
    }\kern\info@kern%
    \mbox{##1}%
    \info@checknext%
  }%
  \vphantom{\strut}\mbox{#2}%
  \info@checknext%
}


% job with title, company, logo, start-end dates, location, highlights
\newcommand{\job}[7]{%
  \vspace{2mm}%
  \global\let\saved@CT@arc@\CT@arc@%
  \arrayrulecolor{gray}
  \begin{tabularx}{\linewidth}{ @{} l @{} X @{} r @{} }%
    \multirow{2}{9mm}{\includegraphics[width=7.2mm]{#3}}% company logo
    & \textbf{#1}     & #4 \\\addlinespace[-.8mm]% position title, date range
    & \footnotesize#2 & \footnotesize\faGlobe~#5\\\cline{2-3}\addlinespace[.8mm]% company, location
  \end{tabularx}%
  \global\let\CT@arc@\saved@CT@arc@%
  \begin{itemize}[
    topsep=0cm,
    parsep=0cm,
    partopsep=0cm,
    itemsep=0cm,
    leftmargin=11.5mm,
    rightmargin=0cm]%
    #6%
  \end{itemize}%
}

% URL / HREF COMMANDS
% -------------------

% \href with icon behind top-right corner
% >> \iurl{https://duckduckgo.com/lite/}{My Text}
\newcommand{\iurl}[2]{%
  % \renewcommand{\ULdepth}{2.2pt}% set how far below \uline is
  \renewcommand{\ULthickness}{0.7pt}% set how thick \uline is
  \contourlength{0.7pt}% set how thick contour is
  \href{#1}%
  {%
    {\color{href@lightblue}\phantom{#2}\rlap{\smash{\hspace{-.6mm}\textsuperscript\faExternalLink}}}%
    \llap{\contour{white}{#2}}%
    \hspace{1.4mm}%
  }
}

% \href with contoured underline and icon behind top-right corner
% >> \lurl{https://duckduckgo.com/lite/}{My Text}
\newcommand{\lurl}[2]{%
  \contourlength{0.7pt}% set how thick contour is
  \href{#1}{%
    \begingroup%
      \color{href@lightblue}%
      \uline{\phantom{#2}}
      \rlap{%
        \smash{%
          \hspace{-.6mm}%
          \textsuperscript\faExternalLink
        }%
      }%
    \endgroup%
    \llap{\contour{white}{#2}}%
    \hspace{1.4mm}%
  }%
}

% \href with contoured underline
% >> \uurl{https://duckduckgo.com/lite/}{My Text}
\newcommand{\uurl}[2]{%
  % \renewcommand{\ULdepth}{2.2pt}% set how far below \uline is
  \renewcommand{\ULthickness}{0.7pt}% set how thick \uline is
  \contourlength{0.7pt}% set how thick contour is
  \href{#1}%
  {%
    {\color{href@lightblue}\uline{\phantom{#2}}}%
    \llap{\contour{white}{#2}}%
  }
}

% add light "Last updated" message to top-left
\newcommand{\placelastupdated}{
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{\paperwidth-1.3 cm},\LenToUnit{\paperheight-0.8 cm})%
    {\vtop{{\null}\makebox[0pt][c]{%
          \begin{minipage}[t]{\maxof{\widthof{\small Last updated}}{\widthof{\small\today}}}%
            \small\color{lightgray}\textit{Last updated\\\today}%
          \end{minipage}%
          \hspace{\maxof{\widthof{\small Last updated}}{\widthof{\small\today}}}%
    }}}%
  }%
}

\makeatother
