return {
	vim.keymap.set("n", "<space>td", function()
		local job_id = 0
		local path = vim.api.nvim_buf_get_name(0)
		local cmd = "docker compose -f"

		-- Setting up the Terminal
		vim.cmd.vnew()
		vim.cmd.term()
		vim.cmd.wincmd("J")
		vim.api.nvim_win_set_height(0, 15)

		job_id = vim.bo.channel

		-- compose up
		vim.fn.chansend(job_id, { string.format("%s %s up -d\r\n", cmd, path) })
	end)
}
