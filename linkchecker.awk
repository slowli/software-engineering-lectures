#!/usr/bin/env awk
BEGIN {
  ii = -1; li = -1; ci = -1; ui = -1; vi = -1; pi = -1; wi = -1; ri = -1
  nwarn = 0; nerr = 0; nredir = 0
  OFS = ""
}
{
  if (ui >= 0) {
    if ($vi ~ /False/) {
      print "Error [", $pi, ":", $li, ":", $ci, "]: ", $ui, " returned ", $ri
      nerr += 1
    } else if ($wi ~ /.+/) {
      print "Warning [", $pi, ":", $li, ":", $ci, "]: ", $ui, ": ", $wi
      nwarn += 1
    } else if ($ii ~ /(R|r)edirect/) {
      print "Redirect [", $pi, ":", $li, ":", $ci, "]: ", $ui, ": ", $ii
      nredir += 1
    }
  }
}
/infostring/ {
  for (i = 1; i <= NF; i++) {
    if ($i ~ /^urlname$/) ui = i
    if ($i ~ /^result$/) ri = i
    if ($i ~ /^infostring$/) ii = i
    if ($i ~ /^warningstring$/) wi = i
    if ($i ~ /^parentname$/) pi = i
    if ($i ~ /^line$/) li = i
    if ($i ~ /^column$/) ci = i
    if ($i ~ /^valid$/) vi = i
  }
}
END {
  print "Errors: ", nerr, " Warnings: ", nwarn, " Redirects: ", nredir
  exit (nerr + nredir > 0) ? 1 : 0
}
