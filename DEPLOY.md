# Hosting This Portfolio

This site is a static website, so it does not need a build step or server runtime.

## Fastest path

1. Run `./scripts/package-site.sh`
2. Upload the generated `deploy/` folder or `portfolio-deploy.zip` to a static host
3. Set your custom domain in the host dashboard if you have one

## Why use the deploy package

- It includes only the files used by the live website
- It excludes large raw media files that are not referenced by any page
- It uses the compressed MP4 version of the drone simulation video

## Good hosting choices

- Netlify Drop for the fastest no-Git upload flow
- Vercel if you want a dashboard and later Git-based updates
- GitHub Pages if you plan to move this into a Git repository and keep large source media out of the repo
- Cloudflare Pages if you keep each deployed asset within its upload limits

## GitHub Pages setup

This project now includes a GitHub Pages-ready workflow:

1. Run `./scripts/sync-github-pages.sh`
2. Create a GitHub repository and push this project
3. In GitHub, go to `Settings` -> `Pages`
4. Set `Build and deployment` to `Deploy from a branch`
5. Choose the `main` branch and the `/docs` folder

The generated site files will live in `docs/`, which is the folder GitHub Pages can publish directly.

## Repeat updates

Whenever you change the website:

1. Update the source files in the project root
2. Run `./scripts/package-site.sh` again for generic static hosting, or `./scripts/sync-github-pages.sh` for GitHub Pages
3. Re-upload `deploy/` or `portfolio-deploy.zip`, or commit and push the updated `docs/` folder
