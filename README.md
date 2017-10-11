## What
A working example of the `Automatic Sequence Computer Mark V` described in Arthur C. Clarke's short story: The Nine Billion Names of God.

Essentially generates ~9 Billion combinations from a 13 letter alphabet (13^9 premutations).

Based on the real world [Rotokas alphabet](https://en.wikipedia.org/wiki/Rotokas_alphabet)).
`a e g i k n o p r s t u v`

Builds names sequentially out of nine letters. Skips over invalid names (ie. that contain 3 repeated letters in a row).

## How
Start with first valid name: AAEAAEAAE
Increment name along the alphabet
Recurse on the name if column reaches end of alphabet and wrap on alphabet
Skip name if contains same letter three times in succession
Return new GOD

## Examples
### Next GOD
Previous: 'AAV'
Next: 'AEA'

### Avoid triples
Previous: 'GGE'
Next: 'GGI'

## Deploy
Gemfile
```
group :production do
  gem 'pg'
end
```
```
$ heroku create
$ heroku addons:create heroku-postgresql:hobby-dev
$ git push heroku master
```