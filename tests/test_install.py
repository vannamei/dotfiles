#!/usr/bin/env python3
"""復元処理が既存設定を失わず、再実行しても安全であることを一時領域で確認する。"""
from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest

REPO = Path(__file__).resolve().parents[1]

class InstallTest(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix='dotfiles-test-')
        self.home = Path(self.tmp.name) / 'home'
        self.home.mkdir()

    def tearDown(self):
        self.tmp.cleanup()

    def run_install(self, *args, repo=REPO):
        env = dict(os.environ, DOTFILES_TARGET_HOME=str(self.home))
        return subprocess.run(['bash', str(repo / 'install.sh'), *args], env=env,
                              capture_output=True, text=True)

    def test_dry_run_changes_nothing(self):
        result = self.run_install()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(list(self.home.iterdir()), [])

    def test_backup_and_idempotent_apply(self):
        (self.home / '.zshrc').write_text('my existing config\n')
        (self.home / '.zprofile').symlink_to(self.home / 'missing-target')
        result = self.run_install('--apply')
        self.assertEqual(result.returncode, 0, result.stderr)
        backups = list((self.home / '.local/state/dotfiles-backups').iterdir())
        self.assertEqual(len(backups), 1)
        self.assertEqual((backups[0] / '.zshrc').read_text(), 'my existing config\n')
        self.assertTrue((backups[0] / '.zprofile').is_symlink())
        self.assertEqual((self.home / '.zshrc').resolve(), REPO / '.zshrc')
        result = self.run_install('--apply')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(list((self.home / '.local/state/dotfiles-backups').iterdir()), backups)

    def test_missing_source_stops_before_changes(self):
        repo = Path(self.tmp.name) / 'incomplete'
        (repo / 'manifests').mkdir(parents=True)
        shutil.copy2(REPO / 'install.sh', repo / 'install.sh')
        (repo / '.zshrc').write_text('replacement')
        (repo / 'manifests/links.txt').write_text('.zshrc\nmissing\n')
        (self.home / '.zshrc').write_text('original')
        result = self.run_install('--apply', repo=repo)
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual((self.home / '.zshrc').read_text(), 'original')
        self.assertFalse((self.home / '.local').exists())

if __name__ == '__main__':
    unittest.main()
