return {
  require("plugins.langs.codeium"),

  -- python
  -- :MasonInstall pyright@1.1.388  << NOT OK
  -- :MasonInstall pyright@1.1.351  << OK
  -- requirement:
  -- tao venv:
  --  --    python3 -m venv venv_molten  && source ./venv_molten/bin/activate
  --  --OR: mkvenv venv_molten && venv venv_molten
  -- pip list
  -- pip install pynvim ipython jupytext jupyter_client jupyter ipykernel notebook
  -- python -m ipykernel install --user --name venv_molten
  -- -- hoac: ipython kernel install --user --name=venv_molten
  require("plugins.langs.python"),
}
