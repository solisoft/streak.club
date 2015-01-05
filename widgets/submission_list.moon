
class SubmissionList extends require "widgets.base"
  @needs: {"submissions"}

  base_widget: false

  show_streaks: true
  show_user: false

  inner_content: =>
    div class: "submission_list", ->
      for submission in *@submissions
        div class: "submission_row", ->
          div class: "avatar", ->
            img src: submission.user\gravatar!

          div class: "submission_content", ->
            div class: "submission_header", ->
              div class: "submission_meta", ->
                text "Submitted #{@format_timestamp submission.created_at}"

              h3 class: "submission_title", ->
                a href: @url_for(submission), submission.title

              h4 class: "submission_summary", ->
                if @show_user
                  text "A submission by "
                  a href: @url_for(@user), @user\name_for_display!
                else
                  text "A submission"

                if @show_streaks and submission.streaks
                  text " for "
                  num_streaks = #submission.streaks
                  for i, streak in ipairs submission.streaks
                    text " "
                    a href: @url_for(streak), streak.title
                    text ", " unless i == num_streaks

            p submission.description

            @render_uploads submission

  render_uploads: (submission) =>
    return unless submission.uploads and next submission.uploads
    div class: "submission_uploads", ->
      for upload in *submission.uploads
        continue unless upload\is_image!
        div class: "submission_upload", ->
          a href: @url_for(upload), target: "_blank", ->
            img src: @url_for(upload, "400x400")


