% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_cj_amce.R, R/plot_cj_diffs.R,
%   R/plot_cj_freqs.R, R/plot_cj_mm.R
\name{plot.cj_amce}
\alias{plot.cj_amce}
\alias{plot.cj_mm}
\alias{plot.cj_freqs}
\alias{plot.cj_diffs}
\alias{plot.cj_freqs}
\alias{plot.cj_mm}
\title{Plot AMCE estimates, MM descriptives, and frequency plots}
\usage{
\method{plot}{cj_amce}(x, group = attr(x, "by"), feature_headers = TRUE,
  header_fmt = "(\%s)", size = 1, xlab = "Estimated AMCE", ylab = "",
  legend_title = if (is.null(group)) "Feature" else group,
  legend_pos = "bottom", xlim = NULL, vline = 0, vline_color = "gray",
  theme = ggplot2::theme_bw(), ...)

\method{plot}{cj_diffs}(x, group = attr(x, "by"), feature_headers = TRUE,
  header_fmt = "(\%s)", size = 1, xlab = "Estimated Difference",
  ylab = "", legend_title = if (is.null(group)) "Feature" else group,
  legend_pos = "bottom", xlim = NULL, vline = 0, vline_color = "gray",
  theme = ggplot2::theme_bw(), ...)

\method{plot}{cj_freqs}(x, group = attr(x, "by"), feature_headers = TRUE,
  header_fmt = "(\%s)", xlab = "", ylab = "Frequency", legend_title = if
  (is.null(group)) "Feature" else group, legend_pos = "bottom",
  theme = ggplot2::theme_bw(), ...)

\method{plot}{cj_mm}(x, group = attr(x, "by"), feature_headers = TRUE,
  header_fmt = "(\%s)", size = 1, xlab = "Marginal Mean", ylab = "",
  legend_title = if (is.null(group)) "Feature" else group,
  legend_pos = "bottom", xlim = NULL, vline = 0, vline_color = "gray",
  theme = ggplot2::theme_bw(), ...)
}
\arguments{
\item{x}{A data frame returned from \code{\link{cj}} or \code{\link{mm}}.}

\item{group}{Optionally a character string specifying a grouping factor. This is useful when, for example, subgroup analyses or comparing AMCEs for different outcomes. An alternative is to use \code{\link[ggplot2]{facet_wrap}} for faceted graphics.}

\item{feature_headers}{A logical indicating whether to include headers for each feature to visually separate levels for each feature (beyond the color palette).}

\item{header_fmt}{A character string specifying a \code{fmt} argument to \code{\link[base]{sprintf}}, which will be used when generating the feature headers (if \code{feature_headers = TRUE}).}

\item{size}{A numeric value specifying point size in \code{\link[ggplot2]{geom_point}}.}

\item{xlab}{A label for the x-axis}

\item{ylab}{A label for the y-axis}

\item{legend_title}{A character string specifying a label for the legend.}

\item{legend_pos}{An argument forwarded to the \code{legend.position} argument in \code{\link[ggplot2]{theme}}.}

\item{xlim}{A two-element number vector specifying limits for the x-axis. If \code{NULL}, a default value is calculated from the data.}

\item{vline}{Optionally, a numeric value specifying an x-intercept for a vertical line. This can be useful in distinguishing the midpoint of the estimates (e.g., a zero line for AMCEs).}

\item{vline_color}{A character string specifying a color for the \code{vline}.}

\item{theme}{A ggplot2 theme object}

\item{\dots}{Ignored.}
}
\value{
A ggplot2 object
}
\description{
ggplot2-based plotting of conjoint AMCEs estimates and MMs
}
\examples{
\donttest{
# load data
data("immigration")

# calculate MMs
d1 <- mm(immigration, ChosenImmigrant ~ Gender + Education + 
         LanguageSkills + CountryOfOrigin + Job + JobExperience + 
         JobPlans + ReasonForApplication + PriorEntry, id = ~ CaseID)

# plot MMs
## simple plot
plot(d1)
## plot with facetting by feature
plot(d1, feature_headers = FALSE) + 
  ggplot2::facet_wrap(~feature, ncol = 1L, 
                      scales = "free_y", strip.position = "right")

# MMs split by profile number
stacked <- cj(immigration, ChosenImmigrant ~ Gender + 
              Education + LanguageSkills + CountryOfOrigin + Job + JobExperience + 
              JobPlans + ReasonForApplication + PriorEntry, id = ~ CaseID,
              estimate = "mm", by = ~ contest_no)

## plot with grouping
plot(stacked, group = "contest_no", feature_headers = FALSE)

## plot with facetting
plot(stacked) + ggplot2::facet_wrap(~contest_no, nrow = 1L)

# estimate AMCEs over different subsets of data
reasons12 <- subset(immigration, ReasonForApplication \%in\% levels(ReasonForApplication)[1:2])
d2_1 <- cj(immigration, ChosenImmigrant ~ CountryOfOrigin, id = ~ CaseID)
d2_2 <- cj(reasons12, ChosenImmigrant ~ CountryOfOrigin, id = ~ CaseID,
           feature_labels = list(CountryOfOrigin = "Country Of Origin"))
d2_1$reasons <- "1,2,3"
d2_2$reasons <- "1,2"
plot(rbind(d2_1, d2_2), group = "reasons")
}
}
\seealso{
\code{\link{amce}}, \code{\link{mm}}
}
