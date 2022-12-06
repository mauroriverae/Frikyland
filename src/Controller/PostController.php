<?php

namespace App\Controller;
use App\Entity\Post;
use App\Entity\User;
use App\Form\PostType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;

class PostController extends AbstractController
{
    private $em;
    /**
     *  @param $em
     */

    public function __construct(EntityManagerInterface $em) 
    {
        $this->em = $em;
    }

    #[Route('/' , name: 'app_post')]
    public function index(Request $request, SluggerInterface $slugger): Response 
    {
        $post = new Post();

        $posts = $this->em->getRepository(Post::class)->findAllPost();

        $form = $this->createForm(PostType::class, $post);
        $form->handleRequest($request);
        if($form->isSubmitted() && $form->isValid()){
            $file = $form->get('file')->getData();
            $url = str_replace(" ", "-", $form->get('title')->getData());

            if($file){
                $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
                $safeFilename = $slugger->slug($originalFilename);

                //slugeer va a cambiar el nombre al archiv asi prevenimos ataques a la db 
                $newFilename = $safeFilename.'-'.uniqid().'.'.$file->guessExtension();

                try {
                    $file->move(
                        $this->getParameter('files_directory'),
                        $newFilename
                    );
                } catch (FileException $e) {
                    throw new \Exception('there is a problem with your file ');
                    // ... handle exception if something happens during file upload
                }

                //slugeer va a cambiar el nombre al archiv asi prevenimos ataques a la db 
                $post ->setFile($newFilename);

            }
            $post -> setUrl($url); 
            $user = $this->em->getRepository(User::class)->find(1);
            $post->setUser($user);

            $this->em->persist($post);
            $this->em->flush();
            return $this->redirectToRoute('app_post');
        }


        return $this->render('post/index.html.twig', [
                'form' => $form->createView(),
                'posts' => $posts
        ]);
    }
    
    #[Route('/post/details/{id}', name: 'postDetails')]
    public function postDetails(Post $post) {

        return $this->render('post/post-details.html.twig', ['post' => $post]);
    }



/* CUD MANUAL
    #[Route('/post/{id}' , name: 'app_post')]
    public function index($id): Response
    {
        $post = $this->em->getRepository(Post::class)->find($id);
        $posts = $this->em->getRepository(Post::class)->findAll($id);
        $postsfindBy = $this->em->getRepository(Post::class)->findBy(['id' => 1, 'title' => 'Mi primer titulo']);
        $postsfindOneBy = $this->em->getRepository(Post::class)->findOneBy(['id' => 1]);

        $custom_post = $this->em->getRepository(Post::class)->findPost($id);
        return $this->render('post/index.html.twig', [
            'post' => $post,
            'posts' => $posts,
            'search' => $postsfindBy,
            'oneBy' => $postsfindOneBy,
            'custom_post' => $custom_post,
        ]);
     }
     
     #[Route('/insert/post' , name: 'insert_post')]
     public function insert() {
        $post = new Post('Otro post insertado', 'opinion', 'hola mundo', 'hola.jpg', 'other');
        $user = $this-> em->getRepository(User::class)->find(1);
        $post->setUser($user);
        $this->em->persist($post);
        $this->em->flush();
        return new JsonResponse(['suceces' => true]); 
     }

     #[Route('/update/post' , name: 'insert_post')]
     public function update() {
        $post = $this->em->getRepository(Post::class)->find(4);
        $post->setTitle('insertado desde update');
        $this->em->flush();
        return new JsonResponse(['suceces' => true]);
     }
     #[Route('/remove/post' , name: 'insert_post')]
     public function remove() {
        $post = $this->em->getRepository(Post::class)->find(4);
        $this->em->remove($post);
        $this->em->flush();
        return new JsonResponse(['suceces' => true]);
     } */
}
