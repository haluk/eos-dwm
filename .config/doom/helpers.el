;;; helpers.el -*- lexical-binding: t; -*-


(defun evil-yank-visible ()
  "Yank only visible text.
If a region is active, yank visible text within that region.
Otherwise, yank all visible text in the buffer."
  (interactive)
  (let* ((start (if (use-region-p) (region-beginning) (point-min)))
         (end   (if (use-region-p) (region-end) (point-max)))
         (text  ""))
    (save-excursion
      (goto-char start)
      (while (< (point) end)
        (unless (invisible-p (point))
          (setq text (concat text (buffer-substring-no-properties
                                   (point) (min (1+ (point)) end)))))
        (forward-char)))
    (kill-new text)))
