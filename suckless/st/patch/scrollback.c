void
kscrolldown(const Arg* a)
{
	int n = a->i;

	if (n < 0)
		n = term.row + n;

	if (n > term.scr)
		n = term.scr;

	if (term.scr > 0) {
		term.scr -= n;
		selscroll(0, -n);
		tfulldirt();
	}

	if (n > 0)
		restoremousecursor();
}

void
kscrollup(const Arg* a)
{
	int n = a->i;
	if (n < 0)
		n = term.row + n;

	if (term.scr + n > term.histn)
		n = term.histn - term.scr;

	if (!n)
		return;

	if (term.scr <= HISTSIZE-n) {
		term.scr += n;
		selscroll(0, n);
		tfulldirt();
	}

	if (n > 0)
		restoremousecursor();
}
