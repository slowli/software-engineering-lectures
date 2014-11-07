%% Lectures - Fixes absolute positioning of rectangle callout pointers

\makeatletter
\pgfdeclareshape{rectangle callout}{%
	\savedmacro\rectanglecalloutpoints{%
		%
		\pgfmathsetlength\pgf@x{\pgfkeysvalueof{/pgf/inner xsep}}%
		\advance\pgf@x.5\wd\pgfnodeparttextbox%
		\pgfmathsetlength\pgf@xa{\pgfkeysvalueof{/pgf/minimum width}}%
		\ifdim\pgf@x<.5\pgf@xa%
			\pgf@x.5\pgf@xa%
		\fi%
		\edef\xtemp{\the\pgf@x}%
		\pgfmathaddtolength\pgf@x{\pgfkeysvalueof{/pgf/outer xsep}}%
		%
		\pgfmathsetlength\pgf@y{\pgfkeysvalueof{/pgf/inner ysep}}%
		\advance\pgf@y.5\ht\pgfnodeparttextbox%
		\advance\pgf@y.5\dp\pgfnodeparttextbox%
		\pgfmathsetlength\pgf@ya{\pgfkeysvalueof{/pgf/minimum height}}%
		\ifdim\pgf@y<.5\pgf@ya%
			\pgf@y.5\pgf@ya%
		\fi%
		\edef\ytemp{\the\pgf@y}%
		\pgfmathaddtolength\pgf@y{\pgfkeysvalueof{/pgf/outer ysep}}%
		%
		\edef\xlength{\the\pgf@x}%
		\edef\ylength{\the\pgf@y}%
		\addtosavedmacro\xlength%
		\addtosavedmacro\ylength%
		%
		\pgfmathsetlengthmacro\pointerwidth{\pgfkeysvalueof{/pgf/callout pointer width}}%
		\addtosavedmacro\pointerwidth%
		%
		\pgfextract@process\centerpoint{%
			\pgf@x.5\wd\pgfnodeparttextbox%
			\pgf@y.5\ht\pgfnodeparttextbox%
			\advance\pgf@y-.5\dp\pgfnodeparttextbox%
		}%
		%
		% Process the relative callout pointer.
		%
		\ifpgf@lib@callout@absolutepointer%
		\else%
			\pgfextract@process\calloutpointer{%
				\pgfextract@process\borderpoint{%
					\expandafter\pgfpointborderrectangle\expandafter{\pgf@lib@callout@relativepointer}%
						{\pgfqpoint{\xtemp}{\ytemp}}%
				}%
				\pgfmathanglebetweenpoints{\pgfpointorigin}{\borderpoint}%
				\let\pointerangle\pgfmathresult%
				\expandafter\pgf@process\expandafter{\pgf@lib@callout@relativepointer}%
				\pgfmathveclen@{\pgfmath@tonumber{\pgf@x}}{\pgfmath@tonumber{\pgf@y}}%
				\edef\pointerradius{\pgfmathresult pt}%
				\pgfpointadd{\borderpoint}{\pgfqpointpolar{\pointerangle}{\pointerradius}}%
				\pgf@xa\pgf@x%
				\pgf@ya\pgf@y%
				\centerpoint%
				\advance\pgf@x\pgf@xa%
				\advance\pgf@y\pgf@ya%
			}%
			\pgf@lib@callouts@shortenpointer%
			\addtosavedmacro\calloutpointer%
			\pgf@lib@rectanglecallout@pointer%
			\addtosavedmacro\calloutpointeranchor%
			\addtosavedmacro\beforecalloutpointer%
			\addtosavedmacro\aftercalloutpointer%
			\addtosavedmacro\firstpoint%
			\addtosavedmacro\secondpoint%
			\addtosavedmacro\thirdpoint%
			\addtosavedmacro\fourthpoint%
		\fi%
	}
	\savedanchor\centerpoint{%
		\pgf@x.5\wd\pgfnodeparttextbox%
		\pgf@y.5\ht\pgfnodeparttextbox%
		\advance\pgf@y-.5\dp\pgfnodeparttextbox%
	}
	\savedanchor\basepoint{%
		\pgf@x.5\wd\pgfnodeparttextbox%
		\pgf@y0pt\relax%
	}
	\savedanchor\midpoint{%
		\pgf@x.5\wd\pgfnodeparttextbox%
		\pgfmathsetlength\pgf@y{+.5em}%
	}
	\anchor{center}{\centerpoint}
	\anchor{mid}{\midpoint}
	\anchor{mid east}{%
		\rectanglecalloutpoints%
		\midpoint%
		\advance\pgf@x\xlength\relax%
	}
	\anchor{mid west}{%
		\rectanglecalloutpoints%
		\midpoint%
		\advance\pgf@x-\xlength\relax%
	}
	\anchor{base}{\basepoint}
	\anchor{base east}{%
		\rectanglecalloutpoints%
		\basepoint%
		\advance\pgf@x\xlength\relax%
	}
	\anchor{base west}{%
		\rectanglecalloutpoints%
		\basepoint%
		\advance\pgf@x-\xlength\relax%
	}
	\anchor{north}{%
		\rectanglecalloutpoints%
		\centerpoint%
		\advance\pgf@y\ylength\relax%
	}%
	\anchor{south}{%
		\rectanglecalloutpoints%
		\centerpoint%
		\advance\pgf@y-\ylength\relax%
	}%
	\anchor{east}{%
		\rectanglecalloutpoints%
		\centerpoint%
		\advance\pgf@x\xlength\relax%
	}%
	\anchor{west}{%
		\rectanglecalloutpoints%
		\centerpoint%
		\advance\pgf@x-\xlength\relax%
	}%
	\anchor{north east}{%
		\rectanglecalloutpoints%
		\centerpoint%
		\advance\pgf@x\xlength\relax%
		\advance\pgf@y\ylength\relax%
	}%
	\anchor{south west}{%
		\rectanglecalloutpoints%
		\centerpoint%
		\advance\pgf@x-\xlength\relax%
		\advance\pgf@y-\ylength\relax%
	}%
	\anchor{south east}{%
		\rectanglecalloutpoints%
		\centerpoint%
		\advance\pgf@x\xlength\relax%
		\advance\pgf@y-\ylength\relax%
	}%
	\anchor{north west}{%
		\rectanglecalloutpoints%
		\centerpoint%
		\advance\pgf@x-\xlength\relax%
		\advance\pgf@y\ylength\relax%
	}%
	\anchor{pointer}{%
		\rectanglecalloutpoints%
		\calloutpointeranchor%
	}%
	\backgroundpath{%
		\rectanglecalloutpoints%
		\pgf@x\xlength\relax%
		\pgf@y\ylength\relax%
		\pgfmathaddtolength\pgf@x{-\pgfkeysvalueof{/pgf/outer xsep}}%
		\pgfmathaddtolength\pgf@y{-\pgfkeysvalueof{/pgf/outer ysep}}%
		\edef\xtemp{\the\pgf@x}%
		\edef\ytemp{\the\pgf@y}%
		%
		% The absolute pointer must be calculated here because the
		% anchor of the shape (which is calculated after the saved
		% macros and points) affects how the pointer joins the 
		% main rectangle. 
		%
		\ifpgf@lib@callout@absolutepointer%
			\pgfextract@process\calloutpointer{%
				\pgfpointanchor{pgf@lib@callout@pointer}{center}%
			}%
			\pgf@lib@callouts@shortenpointer%
			\pgfmathsetlengthmacro\pointerwidth{\pgfkeysvalueof{/pgf/callout pointer width}}%
			\pgf@lib@rectanglecallout@pointer%
			%
			% \pgf@test = the shape name (from \pgfmultipartnode)
			%
			\edef\pgf@test{pgf@lib@callout@pointer} % << FIX
			\ifx\pgf@test\pgfutil@empty%
			\else%
				%
				% Now hack an extra saved anchor \calloutpointeranchor,
				% with the new anchor for the callout pointer.
				%
				\edef\pgf@sh@@temp{\noexpand\expandafter\noexpand\pgfutil@g@addto@macro\noexpand\csname pgf@sh@np@\pgf@test\noexpand\endcsname}%
				\edef\pgf@sh@@@temp{%
					\noexpand\def\noexpand\calloutpointeranchor{%
						\noexpand\pgf@x\the\pgf@x%
						\noexpand\pgf@y\the\pgf@y%
					}%
				}%
				\expandafter\pgf@sh@@temp\expandafter{\pgf@sh@@@temp}%
			\fi%
		\fi%
		{%
			\pgfsetcornersarced{\pgfqpoint{0pt}{0pt}}%
			\pgfpathmoveto{\beforecalloutpointer}%
		}%
		\pgfpathlineto{\calloutpointer}%
		{%
			\pgfsetcornersarced{\pgfqpoint{0pt}{0pt}}%
			\pgfpathlineto{\aftercalloutpointer}%
		}%
		{%
			\pgftransformshift{\centerpoint}%
			\pgfpathlineto{\firstpoint}%
			\pgfpathlineto{\secondpoint}%
			\pgfpathlineto{\thirdpoint}%
			\pgfpathlineto{\fourthpoint}%
			{%
				\pgfsetcornersarced{\pgfqpoint{0pt}{0pt}}%
				\pgfpathclose%
			}%
		}			
	}
	\anchorborder{%
		\pgfextract@process\externalpoint{}%
		\rectanglecalloutpoints%
		\pgfpointadd{\centerpoint}%
		{%
			\pgfpointborderrectangle{\pgfpointadd{\centerpoint}{\externalpoint}}%
			{\pgfqpoint{\xlength}{\ylength}}%
		}%
	}%
}

