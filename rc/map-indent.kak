provide-module map-indent %{
	define-command -hidden map-indent-check-0-0 nop
	declare-option -hidden int tmp_tabstop

	define-command -hidden map-indent-execute-tab %{
		try %{
			# Indent with tab
			"map-indent-check-0-%opt{indentwidth}"
			execute-keys <tab>
		} catch %{
			# Indent with spaces
			execute-keys <tab>
			execute-keys -draft h %opt{indentwidth} @
		}
	}

	define-command -hidden map-indent-execute-backspace %{
		try %{
			# Deindent tab
			"map-indent-check-0-%opt{indentwidth}"
			execute-keys <backspace>
		} catch %{
			# Deindent spaces if at line beginning
			try %{
				execute-keys -draft <a-h> <a-k> \A..+\z <ret>
				execute-keys -draft h <a-h> <a-K> [^\ ] <ret> %opt{indentwidth} <a-@>
				execute-keys <backspace>
				execute-keys -draft h <a-h> %opt{indentwidth} @
			} catch %{
				execute-keys <backspace>
			}
		}
	}
}
