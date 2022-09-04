import Head from 'next/head'
import Image from 'next/image'
import styles from '../styles/Home.module.css'

export default function Home() {
  return (
    <div className={styles.container}>
      <Head>
        <title>Cocktails</title>
        <meta name="description" content="Cocktail Recipe App" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>
          Cocktails
        </h1>

        <p className={styles.description}>
          Search for cocktail recipes
        </p>
      </main>

      <footer className={styles.footer}>
        An app by Brian Patzin
      </footer>
    </div>
  )
}
